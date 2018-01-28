class AnalysisStepsController < ApplicationController
    include Wicked::Wizard
    before_action :get_session, only: [:show, :update]
    before_action :get_project, :get_datum, only: [:update]
    steps :job_info

    def show
        tool = ToolItem.new
        
        #factory method : create tool_item instance
        @tool_item = ToolFactory.build(@tool_item_cont)

        # @user = current_user
        # case step
        # when :add_twitter
        #   skip_step if @user.zip.blank?
        # end
        render_wizard
    end
    
    def update

        tool = ToolItem.new

        # save input option to tool_item
        @tool_item = ToolFactory.build(@tool_item_cont, mhci_params)
        if (@tool_item.getType == "MHC-I")
            @tool_item.datum = @datum
        end

        tool.itemable = @tool_item
        @tool_item.tool_item = tool
        
        # create analysis
        analysis = Analysis.new()
        analysis.title = @title
        analysis.description = @desc
        analysis.datum = @datum
        analysis.project = @project
        analysis.tool_item = tool
        analysis.save

        # create tool_item and tool instance
        tool.analysis = analysis
        tool.save
        @tool_item.save

        # @user = current_user
        # @user.update_attributes(params[:user])
        render_wizard @tool_item
    end

private
    def finish_wizard_path
        projects_path
    end

    def get_session
        @project_id = session[:project_id]
        @datum_id = session[:datum_id]
        @tool_item_cont = session[:analysis_toolitem]
        @title = session[:analysis_title]
        @desc = session[:analysis_description]

        @seq = Datum.find(@datum_id).content
    end

    def get_project
        @project = Project.find(@project_id)
    end

    def get_datum
        @datum = Datum.find(@datum_id)
    end

    def mhci_params
        params.require(:mhci_item).permit(:name, :prediction_method, :species, :alleles, :output_sort)
    end
end
