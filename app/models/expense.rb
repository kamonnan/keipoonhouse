class Expense < ApplicationRecord
  belongs_to :paid_by,
    class_name: "User"
  belongs_to :created_by,
    class_name: "User"

  has_many :expense_participants,
    dependent: :destroy

  has_many :expense_participants, dependent: :destroy

  has_many :expense_items, dependent: :destroy

  accepts_nested_attributes_for :expense_items,
  allow_destroy: true
end
