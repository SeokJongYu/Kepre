class AnalysesController < ApplicationController
  before_action :set_analysis, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:new, :create]
  before_action :set_datum, only: [:new, :create]

  # GET /analyses
  # GET /analyses.json
  def index
    @analyses = Analysis.all
  end

  # GET /analyses/1
  # GET /analyses/1.json
  def show
  end

  # GET /analyses/new
  def new

    @analysis = Analysis.new
    @analysis.datum = @datum
    @analysis.project = @project
    # @analysis.build_tool_item
    
  end

  # GET /analyses/1/edit
  def edit
  end

  # POST /analyses
  # POST /analyses.json
  def create
    @analysis = Analysis.new(analysis_params)

    respond_to do |format|
      if @analysis.check
        session[:project_id]=@project.id
        session[:datum_id]=@datum.id
        session[:analysis_title]=@analysis.title
        session[:analysis_description]=@analysis.description
        session[:analysis_toolitem] = params[:analysis][:tool_item]
        format.html { redirect_to analysis_steps_path, notice: 'Analysis was successfully created.' }
        format.json { render :show, status: :created, location: @analysis }
      else
        format.html { render :new }
        format.json { render json: @analysis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /analyses/1
  # PATCH/PUT /analyses/1.json
  def update
    respond_to do |format|
      if @analysis.update(analysis_params)
        format.html { redirect_to @analysis, notice: 'Analysis was successfully updated.' }
        format.json { render :show, status: :ok, location: @analysis }
      else
        format.html { render :edit }
        format.json { render json: @analysis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /analyses/1
  # DELETE /analyses/1.json
  def destroy
    @analysis.destroy
    respond_to do |format|
      format.html { redirect_to analyses_url, notice: 'Analysis was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_analysis
      @analysis = Analysis.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def analysis_params
      #params.fetch(:analysis, {})
      params.require(:analysis).permit(:title, :description)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.friendly.find(params[:project_id])
    end
    def set_datum
      @datum = Datum.find(params[:datum_id])
    end
end
