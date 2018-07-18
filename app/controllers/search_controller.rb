class SearchController < ApplicationController
  def search
    results = NewsLog.search(params[:search])
    @sorted_results = Kaminari.paginate_array(results).page(params[:page]).per(10)
  end
end
