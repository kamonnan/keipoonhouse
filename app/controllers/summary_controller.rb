class SummaryController < ApplicationController
  def index
    @current_user =
      User.find_by(id: session[:user_id])

    unless @current_user
      redirect_to root_path
      return
    end

    balances = Hash.new(0)

    raw_debts = Hash.new(0)

    Expense.includes(
      expense_items: :expense_item_participants
    ).find_each do |expense|
      expense.expense_items.each do |item|
        participants =
          item.expense_item_participants

        next if participants.empty?

        split_amount =
          item.amount.to_f / participants.count

        participants.each do |participant|
          next if participant.paid?

          next if participant.user_id ==
                  expense.paid_by_id

          debtor_id =
            participant.user_id

          creditor_id =
            expense.paid_by_id

          # balances

          balances[debtor_id] -= split_amount
          balances[creditor_id] += split_amount

          # debt pair

          key =
            "#{debtor_id}-#{creditor_id}"

          raw_debts[key] += split_amount
        end
      end
    end

    # normalize reverse debts

    normalized = {}

    raw_debts.each do |key, amount|
      debtor_id,
      creditor_id =
        key.split("-").map(&:to_i)

      reverse_key =
        "#{creditor_id}-#{debtor_id}"

      reverse_amount =
        raw_debts[reverse_key]

      next if normalized[key]
      next if normalized[reverse_key]

      final_amount =
        amount - reverse_amount

      if final_amount > 0

        normalized[key] = {
          debtor: User.find(debtor_id),
          creditor: User.find(creditor_id),
          amount: final_amount
        }

      elsif final_amount < 0

        normalized[reverse_key] = {
          debtor: User.find(creditor_id),
          creditor: User.find(debtor_id),
          amount: final_amount.abs
        }

      end
    end

    @balances =
      balances.reject { |_, v| v.abs < 0.01 }

    @net_balance =
      @balances[@current_user.id] || 0

    @debts =
      normalized.values.select do |debt|
        debt[:debtor].id ==
          @current_user.id ||

        debt[:creditor].id ==
          @current_user.id
      end
  end
end
