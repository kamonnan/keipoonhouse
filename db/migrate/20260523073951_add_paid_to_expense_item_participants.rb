class AddPaidToExpenseItemParticipants < ActiveRecord::Migration[8.0]
  def change
    add_column :expense_item_participants, :paid, :boolean, default: false
  end
end
