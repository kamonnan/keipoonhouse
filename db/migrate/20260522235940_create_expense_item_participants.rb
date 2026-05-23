class CreateExpenseItemParticipants < ActiveRecord::Migration[8.0]
  def change
    create_table :expense_item_participants do |t|
      t.references :expense_item, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
