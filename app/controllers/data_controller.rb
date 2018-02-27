require 'bio'

class DataController < ApplicationController
  before_action :get_project
  before_action :set_datum, only: [:show, :edit, :update, :destroy]



  def get_project
    @project = Project.friendly.find(params[:project_id])
  end

  # GET /data
  # GET /data.json
  def index
    @datum = @project.data.all
  end

  # GET /data/1
  # GET /data/1.json
  def show
    @analyses = Analysis.where( datum_id: @datum.id)
    @fasta = Bio::FastaFormat.new(@datum.content)
  end

  # GET /data/new
  def new
    @datum = @project.data.new
  end

  # GET /data/1/edit
  def edit
  end

  # POST /data
  # POST /data.json
  def create
    @datum = @project.data.new(datum_params)

    respond_to do |format|
      if @datum.save
        update_data_info
        format.html { redirect_to project_url(@project), notice: 'Datum was successfully created.' }
        format.json { render :show, status: :created, location: @datum }
      else
        format.html { render :new }
        format.json { render json: @datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /data/1
  # PATCH/PUT /data/1.json
  def update
    respond_to do |format|
      if @datum.update(datum_params)
        format.html { redirect_to project_url(@project), notice: 'Datum was successfully updated.' }
        format.json { render :show, status: :ok, location: @datum }
      else
        format.html { render :edit }
        format.json { render json: @datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /data/1
  # DELETE /data/1.json
  def destroy
    @datum.destroy
    respond_to do |format|
      format.html { redirect_to data_url, notice: 'Datum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_datum
      @datum = Datum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def datum_params
      params.require(:datum).permit(:name, :content, :data_type)
    end

    # Get the project object
    #def get_project
    #  @project = Project.find(params[:project_id])
    #end

    def update_data_info
      @dashboard = current_user.dashboard
      @curr_data = @dashboard.total_data
      @dashboard.total_data = @curr_data + 1
      @dashboard.save
    end
end
