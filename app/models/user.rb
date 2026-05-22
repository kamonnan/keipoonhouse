class User < ApplicationRecord
  has_many :paid_expenses,
    class_name: "Expense",
    foreign_key: "paid_by_id"

  has_many :created_expenses,
    class_name: "Expense",
    foreign_key: "created_by_id"

  has_many :expense_participants

  has_many :sent_settlements,
  class_name: "Settlement",
  foreign_key: "from_user_id"

  has_many :received_settlements,
  class_name: "Settlement",
  foreign_key: "to_user_id"
end
