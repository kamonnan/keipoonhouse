class CreateExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :expenses do |t|
      t.string :title
      t.decimal :amount

      t.references :paid_by, foreign_key: { to_table: :users }
      t.references :created_by, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
