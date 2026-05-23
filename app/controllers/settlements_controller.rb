class SettlementsController < ApplicationController
  def create
    participant =
      ExpenseItemParticipant.find(params[:id])

    participant.update!(paid: true)

    redirect_to summary_path
  end
end
