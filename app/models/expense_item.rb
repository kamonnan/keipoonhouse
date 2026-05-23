class ExpenseItem < ApplicationRecord
  belongs_to :expense

  has_many :expense_item_participants,
    dependent: :destroy
end
