class NewsLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_news_log, only: [:show, :edit, :update, :destroy,:get_document,:history]
  before_action :set_form_data, only: [:new, :edit, :create, :update]
  # GET /news_logs
  # GET /news_logs.json
  def index
    @news_logs = NewsLog.order(:created_at => "DESC").page params[:page]
    authorize @news_logs
  end

  # GET /news_logs/1
  # GET /news_logs/1.json
  def show
    authorize @news_log
  end

  # GET /news_logs/new
  def new
    @news_log = NewsLog.new
    authorize @news_log
  end

  # GET /news_logs/1/edit
  def edit
    authorize @news_log
  end

  def get_document
    content = @news_log.document.read
    if stale?(etag: content, last_modified: @news_log.updated_at.utc, public: true)
      file_name = @news_log.document.try(:file).path.split("/").last rescue "NewsRelease_#{news_log.id.to_s}"
      send_data content, type: @news_log.document.file.content_type, disposition: "inline" , :filename => file_name
      expires_in 0, public: true
    end
  end

  def history
     @histories = @news_log.history_tracks.order(:version => "DESC").page params[:page]
  end

  # POST /news_logs
  # POST /news_logs.json
  def create
    @news_log = NewsLog.new(news_log_params)
    @news_log.user = current_user

    authorize @news_log
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
    authorize @news_log
    respond_to do |format|
      if @news_log.update(news_logs_update_params)
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
    authorize @news_log
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

    def set_form_data
      @agency_hash ||= { "Frequently Used" => Agency.where(:frequently_used => true).all.map{|b| [b.name,b.id]},
        "--------------" => Agency.where(:frequently_used.ne => true).all.map{|b| [b.name,b.id]}}
      @region_hash ||= Hash[Region.all.map{|b| [b.name,b.id]}]
      @distributionlist_hash ||= Hash[Distributionlist.all.map{|b| [b.name,b.id]}]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_log_params
      new_params= params.require(:news_log).permit(:received_date, :release_date, :title, :user_id, :agency_id, :region_id, :document, :distributionlist_ids =>[])
      new_params[:received_date] = DateTime.strptime(new_params[:received_date],"%m/%d/%Y") unless new_params[:received_date].blank?
      new_params[:release_date] = DateTime.strptime(new_params[:release_date],"%m/%d/%Y") unless new_params[:release_date].blank?
      new_params.merge!({:modifier => current_user})
    end

    def news_logs_update_params
      update_params = params.require(:news_log).permit(:release_date, :title, :user_id, :agency_id, :region_id,:document,:received_date, :distributionlist_ids =>[])
      update_params[:release_date] = DateTime.strptime(update_params[:release_date],"%m/%d/%Y") unless update_params[:release_date].blank?
      new_state = params[:to].try(:keys).first if params[:to].present?
      update_params[:aasm_state] = params[:to].try(:keys).first if new_state && NewsLog.aasm.states.map(&:name).include?(new_state.to_sym)
      update_params.merge!({:modifier => current_user})
    end
end
