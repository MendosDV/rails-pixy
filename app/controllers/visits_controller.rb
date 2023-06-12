class VisitsController < ApplicationController
  # before_action :set_visit, only: [:show]

  def index
    @visits = Visit.all
  end

  def show
    @visit = Visit.find(params[:id])
  end


  # private

  # def set_visit
  #   @visit = Visit.find(params[:id])
  # end

  # def visit_params
  #   params.require(:visit).permit(:profile_id, :url, :date, :words_changed)
  # end

end
