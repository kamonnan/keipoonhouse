class CreateBills < ActiveRecord::Migration[8.0]
  def change
    create_table :bills do |t|
      t.string :name

      t.timestamps
    end
  end
end
