class ExpensesController < ApplicationController
  def new
    @users = User.all
    @expense = Expense.new
  end

  def create
    @expense = Expense.create!(
      title: params[:expense][:title],
      amount: params[:expense][:amount],
      paid_by_id: params[:expense][:paid_by_id],
      created_by_id: session[:user_id]
    )

    participant_ids = params[:expense][:participant_ids].reject(&:blank?)
    split_amount = @expense.amount.to_f / participant_ids.count

    participant_ids.each do |user_id|
      ExpenseParticipant.create!(
        expense: @expense,
        user_id: user_id,
        amount_owed: split_amount
      )
    end

    redirect_to summary_path, notice: "Expense added"
  end

  def index
    @expenses = Expense.includes(:expense_participants, :paid_by, :created_by).order(created_at: :desc)
  end

  def destroy
    expense = Expense.find(params[:id])
    expense.destroy

    redirect_to expenses_path, notice: "Expense deleted"
  end
end
