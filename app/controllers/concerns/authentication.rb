module Authentication
    extend ActiveSupport::Concern
    
    included do
      before_action :current_user
      helper_method :current_user
      helper_method :user_signed_in?
    end
  
    def login(user)
      reset_session
      session[:current_user_id] = user.id
    end
  
    def logout
      reset_session
    end
  
    def redirect_if_authenticated
      begin
        if current_user.is_admin
          redirect_to "/admin", alert: "You are already logged in." if user_signed_in?
        else
          redirect_to "/home", alert: "You are already logged in." if user_signed_in?
        end
          
      rescue
        redirect_to "/home" if user_signed_in? 
      end
    end
  
    private
  
    def current_user
      Current.user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
    end
  
    def user_signed_in?
      Current.user.present?
    end

    def redirect_if_not_admin
      redirect_to "/home" unless current_user.is_admin
    end
  
end