class ExpensesController < ApplicationController
  before_action :set_users,
    only: [ :new, :create, :edit, :update ]

  def index
    @expenses =
      Expense.includes(
        expense_items: :expense_item_participants
      ).order(created_at: :desc)
  end

  def new
    @expense = Expense.new
    @expense.expense_items.build
  end

  def create
    @expense = Expense.create!(
      title: expense_params[:title],
      paid_by_id: session[:user_id]
    )

    build_items(@expense)

    redirect_to summary_path
  end

  def edit
    @expense =
      Expense.includes(
        expense_items: :expense_item_participants
      ).find(params[:id])
  end

  def update
    @expense = Expense.find(params[:id])

    # reset everything
    @expense.expense_items.destroy_all

    @expense.update!(
      title: expense_params[:title]
    )

    build_items(@expense)

    redirect_to expenses_path
  end

  def destroy
    expense = Expense.find(params[:id])

    expense.destroy

    redirect_to expenses_path
  end

  private

  def build_items(expense)
    total_amount = 0

    expense_params[:expense_items_attributes].each_value do |item|
      next if item[:title].blank?

      expense_item =
        expense.expense_items.create!(
          title: item[:title],
          amount: item[:amount]
        )

      total_amount += item[:amount].to_f

      participant_ids =
        (item[:participant_ids] || []).reject(&:blank?)

      next if participant_ids.empty?

      split_amount =
        item[:amount].to_f / participant_ids.count

      participant_ids.each do |user_id|
        ExpenseItemParticipant.create!(
          expense_item: expense_item,
          user_id: user_id,
          amount_owed: split_amount,
          paid: false
        )
      end
    end

    expense.update!(amount: total_amount)
  end

  def set_users
    @users = User.all
  end

  def expense_params
    params.require(:expense).permit(
      :title,
      expense_items_attributes: [
        :title,
        :amount,
        participant_ids: []
      ]
    )
  end
end
