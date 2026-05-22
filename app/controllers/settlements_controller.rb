class SettlementsController < ApplicationController
  def create
    Settlement.create!(
      from_user_id: params[:from_user_id],
      to_user_id: params[:to_user_id],
      amount: params[:amount]
    )

    redirect_to summary_path
  end
end
