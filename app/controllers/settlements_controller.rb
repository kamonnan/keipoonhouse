class SettlementsController < ApplicationController
  def create
    from_user_id =
      params[:user_id].to_i

    paid_to_id =
      params[:paid_to_id].to_i

    Expense.includes(
      expense_items: :expense_item_participants
    ).find_each do |expense|
      next unless expense.paid_by_id == paid_to_id

      expense.expense_items.each do |item|
        item.expense_item_participants.each do |participant|
          next unless participant.user_id == from_user_id

          next if participant.paid?

          participant.update!(
            paid: true
          )
        end
      end
    end

    redirect_to summary_path,
      notice: "Marked as paid"
  end
end
