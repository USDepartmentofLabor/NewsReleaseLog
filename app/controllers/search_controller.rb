class SearchController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_all_empty_params, only: [:advanced_search]
  before_action :check_start_from_dates, only: [:advanced_search]

  def search
    unless params[:search].blank?
      @results = NewsLog.search(params[:search])
      @page_results = Kaminari.paginate_array(@results).page(params[:page])
    else
      redirect_to root_path, alert: "Please enter a valid Title or NewsRelease number"
    end
  end

  def advanced_search
    begin
      if params[:search].present?
        search_params= params.require(:search).permit(:title, :agency, :region ,:received_date,:release_date => {},:received_date=>{},:aasm_state =>[])
        @results = NewsLog.filter(search_params.to_h)
        if @results.present?
          @page_results = Kaminari.paginate_array(@results).page(params[:page])
        else
          @page_results=[]
        end
        respond_to do |format|
          format.html { render 'search' }
          format.csv { send_data NewsLog.to_csv(@results), filename: "news-log-report-#{Date.today}.csv" }
        end
      else
        render 'advanced_search'
      end
    rescue => e
      redirect_to request.referer, alert: "Please check your input fields"
    end
  end

  def check_start_from_dates
    unless params[:search].nil?
      if params.dig(:search, :release_date, :end_date) < params.dig(:search, :release_date, :start_date)
        redirect_to "/advsearch", alert: 'To Date cannot be less than From Date'
        return
      end
      if params.dig(:search, :received_date, :end_date) < params.dig(:search, :received_date, :start_date)
        redirect_to "/advsearch", alert: 'To Date cannot be less than From Date'
        return
      end
    end
  end

  def check_if_all_empty_params
    unless params[:search].nil?
      if params.dig(:search, :title).blank? &&
         params.dig(:search, :agency).blank? &&
         params.dig(:search, :region).blank? &&
         params.dig(:search, :release_date, :start_date).blank? &&
         params.dig(:search, :release_date, :end_date).blank? &&
         params.dig(:search, :received_date, :start_date).blank? &&
         params.dig(:search, :received_date, :end_date).blank?
         redirect_to "/advsearch", alert: 'Please choose or enter one filter parameter'
      end
    end
  end
end
