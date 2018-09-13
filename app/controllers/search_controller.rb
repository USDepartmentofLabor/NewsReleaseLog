class SearchController < ApplicationController
  def search
    unless params[:search].blank?
      results = NewsLog.search(params[:search])
      @page_results = Kaminari.paginate_array(results).page(params[:page]).per(10)
    else
      redirect_to root_path, alert: "Please enter a valid Title or NewsRelease number"
    end
  end

  # def advanced_search_get
  #   render :advanced_search
  # end

  def advanced_search
    if params[:search].present?
      search_params= params.require(:search).permit(:title, :agency, :region ,:received_date,:release_date => {},:received_date=>{},:aasm_state =>[])
      results = NewsLog.filter(search_params.to_h)
      if results.present?
       @page_results = Kaminari.paginate_array(results).page(params[:page]).per(25)
      else 
        @page_results=[]
      end
      render 'search'
    else
      render 'advanced_search'
    end
    
  end
end
