class SearchController < ApplicationController
  def search
    unless params[:search].blank?
      results = NewsLog.search(params[:search])
      @sorted_results = Kaminari.paginate_array(results).page(params[:page]).per(10)
    else
      redirect_to root_path, alert: "Please enter a valid Title or NewsRelease number"
    end
  end

  def advanced_search_get
    render :advanced_search
  end

  def advanced_search_post
    unless params[:search].blank?
      results = NewsLog.advanced_search(params[:search], params[:agency], params[:region])
      @sorted_results = Kaminari.paginate_array(results).page(params[:page]).per(10)
      render 'search'
    end
  end
end
