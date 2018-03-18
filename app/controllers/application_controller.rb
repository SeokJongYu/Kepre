class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    
  end

  def after_sign_in_path_for(resource)
    if current_user.dashboard == nil
      @dashboard = current_user.create_dashboard(project_count: 0, analysis_count: 0, execution_time: 0, avg_time: 0.0, total_data: 0)
      @dashboard.save
    end

    root_path
  end
  
end
