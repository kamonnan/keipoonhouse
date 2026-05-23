class ExpensesController < ApplicationController
  def new
    @users = User.all
    @expense = Expense.new

    @expense.expense_items.build
  end

  def create
    @expense = Expense.create!(
      title: expense_params[:title],
      paid_by_id: session[:user_id],
      created_by_id: session[:user_id]
    )

    total_amount = 0

    expense_params[:expense_items_attributes].each_value do |item|
      next if item[:title].blank?

      expense_item = @expense.expense_items.create!(
        title: item[:title],
        amount: item[:amount]
      )

      total_amount += item[:amount].to_f
    end

    @expense.update!(amount: total_amount)

    participant_ids = expense_params[:participant_ids].reject(&:blank?)

    split_amount = total_amount / participant_ids.count

    participant_ids.each do |user_id|
      ExpenseParticipant.create!(
        expense: @expense,
        user_id: user_id,
        amount_owed: split_amount
      )
    end

    redirect_to summary_path
  end

  def index
    @expenses = Expense.includes(:expense_participants, :paid_by, :created_by).order(created_at: :desc)
  end

  def destroy
    expense = Expense.find(params[:id])
    expense.destroy

    redirect_to expenses_path, notice: "Expense deleted"
  end

  private

  def expense_params
    params.require(:expense).permit(
      :title,
      :paid_by_id,
      participant_ids: [],
      expense_items_attributes: [
        :title,
        :amount
      ]
    )
  end
end
