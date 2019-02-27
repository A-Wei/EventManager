class SearchesController < ApplicationController
  def create
    @results = Event.search_by_title(search_params[:term])
  end

  private

  def search_params
    params.require(:search).permit(:term)
  end
end
