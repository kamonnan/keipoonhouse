class AddAmountOwedToExpenseItemParticipants < ActiveRecord::Migration[8.0]
  def change
    add_column :expense_item_participants, :amount_owed, :decimal
  end
end
