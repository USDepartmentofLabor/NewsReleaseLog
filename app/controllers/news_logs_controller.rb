class NewsLogsController < ApplicationController
  before_action :set_news_log, only: [:show, :edit, :update, :destroy]

  # GET /news_logs
  # GET /news_logs.json
  def index
    @news_logs = NewsLog.all
  end

  # GET /news_logs/1
  # GET /news_logs/1.json
  def show
  end

  # GET /news_logs/new
  def new
    @news_log = NewsLog.new
  end

  # GET /news_logs/1/edit
  def edit
  end

  # POST /news_logs
  # POST /news_logs.json
  def create
    @news_log = NewsLog.new(news_log_params)

    respond_to do |format|
      if @news_log.save
        format.html { redirect_to @news_log, notice: 'News log was successfully created.' }
        format.json { render :show, status: :created, location: @news_log }
      else
        format.html { render :new }
        format.json { render json: @news_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news_logs/1
  # PATCH/PUT /news_logs/1.json
  def update
    respond_to do |format|
      if @news_log.update(news_log_params)
        format.html { redirect_to @news_log, notice: 'News log was successfully updated.' }
        format.json { render :show, status: :ok, location: @news_log }
      else
        format.html { render :edit }
        format.json { render json: @news_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news_logs/1
  # DELETE /news_logs/1.json
  def destroy
    @news_log.destroy
    respond_to do |format|
      format.html { redirect_to news_logs_url, notice: 'News log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news_log
      @news_log = NewsLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_log_params
      params.require(:news_log).permit(:received_date, :release_date, :title, :user_id, :agency_id, :region_id, :distributionlist_id)
    end
end