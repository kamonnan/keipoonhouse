class CreateExpenseItems < ActiveRecord::Migration[8.0]
  def change
    create_table :expense_items do |t|
      t.references :expense, null: false, foreign_key: true
      t.string :title
      t.decimal :amount

      t.timestamps
    end
  end
end
