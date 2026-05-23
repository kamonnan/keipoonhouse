class SummaryController < ApplicationController
  def index
    @current_user =
      User.find(session[:user_id])

    balances = Hash.new(0)

    @unpaid_participants = []

    Expense.includes(
      expense_items: :expense_item_participants
    ).find_each do |expense|
      expense.expense_items.each do |item|
        participants =
          item.expense_item_participants

        split_count = participants.count

        next if split_count == 0

        split_amount =
          item.amount.to_f / split_count

        participants.each do |participant|
          next if participant.paid?

          next if participant.user_id ==
                  expense.paid_by_id

          balances[participant.user_id] -= split_amount

          balances[expense.paid_by_id] += split_amount

          @unpaid_participants << {
            participant: participant,
            expense: expense,
            amount: split_amount
          }
        end
      end
    end

    @balances =
      balances.reject { |_, v| v.abs < 0.01 }

    @net_balance =
      @balances[@current_user.id] || 0
  end
end
