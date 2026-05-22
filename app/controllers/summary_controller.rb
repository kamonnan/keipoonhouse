class SummaryController < ApplicationController
  def index
    return redirect_to root_path unless session[:user_id]

    @current_user = User.find(session[:user_id])

    balances = Hash.new(0)

    Expense.includes(:expense_participants).find_each do |expense|
      split_count = expense.expense_participants.count
      next if split_count == 0

      share = expense.amount.to_f / split_count

      balances[expense.paid_by_id] += expense.amount.to_f

      expense.expense_participants.each do |p|
        balances[p.user_id] -= share
      end
    end

    @balances = balances
    @net_balance = balances[@current_user.id] || 0
    @settlements = DebtSimplifier.call(balances)
  end
end
