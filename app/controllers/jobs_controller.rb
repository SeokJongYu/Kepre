class JobsController < ApplicationController
  def show

    @analyses = Analysis.joins(:project).where("projects.user_id = ? AND status != ?", current_user.id, "Finish")
    #@analyses = Analysis.where ("status != 'Finish'")

  end
end
