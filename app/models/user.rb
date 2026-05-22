class User < ApplicationRecord
  has_many :paid_expenses,
    class_name: "Expense",
    foreign_key: "paid_by_id"

  has_many :created_expenses,
    class_name: "Expense",
    foreign_key: "created_by_id"

  has_many :expense_participants
end
