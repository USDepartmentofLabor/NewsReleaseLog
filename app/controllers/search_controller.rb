class SearchController < ApplicationController
  def search
    @results = NewsLog.search(params[:search])
  end
end
