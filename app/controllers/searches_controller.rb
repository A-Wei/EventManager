class SearchesController < ApplicationController
  def create
    @results = Search.for(search_params[:term])
  end

  private

  def search_params
    params.require(:search).permit(:term)
  end
end
