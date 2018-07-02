class DistributionlistsController < ApplicationController
  before_action :set_distributionlist, only: [:show, :edit, :update, :destroy]

  # GET /distributionlists
  # GET /distributionlists.json
  def index
    @distributionlists = Distributionlist.order(:created_at => "DESC").page params[:page]
  end

  # GET /distributionlists/1
  # GET /distributionlists/1.json
  def show
  end

  # GET /distributionlists/new
  def new
    @distributionlist = Distributionlist.new
  end

  # GET /distributionlists/1/edit
  def edit
  end

  # POST /distributionlists
  # POST /distributionlists.json
  def create
    @distributionlist = Distributionlist.new(distributionlist_params)

    respond_to do |format|
      if @distributionlist.save
        format.html { redirect_to @distributionlist, notice: 'Distributionlist was successfully created.' }
        format.json { render :show, status: :created, location: @distributionlist }
      else
        format.html { render :new }
        format.json { render json: @distributionlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /distributionlists/1
  # PATCH/PUT /distributionlists/1.json
  def update
    respond_to do |format|
      if @distributionlist.update(distributionlist_params)
        format.html { redirect_to @distributionlist, notice: 'Distributionlist was successfully updated.' }
        format.json { render :show, status: :ok, location: @distributionlist }
      else
        format.html { render :edit }
        format.json { render json: @distributionlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /distributionlists/1
  # DELETE /distributionlists/1.json
  def destroy
    @distributionlist.destroy
    respond_to do |format|
      format.html { redirect_to distributionlists_url, notice: 'Distributionlist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_distributionlist
      @distributionlist = Distributionlist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def distributionlist_params
      params.require(:distributionlist).permit(:name, :abbr, :status, :description)
    end
end