class SearchController < ApplicationController
  def search
    unless params[:search].blank?
      results = NewsLog.search(params[:search])
      @sorted_results = Kaminari.paginate_array(results).page(params[:page]).per(10)
    else
      redirect_to root_path, alert: "Please enter a valid Title or NewsRelease number "
    end
  end
end
