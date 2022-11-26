class SessionsController < ApplicationController
    before_action :redirect_if_authenticated, only: [:create, :new]
    
    def create
        begin
            @user = User.find_by(email: params[:user][:email].downcase)
            if @user.authenticate(params[:user][:password])
                if @user.is_admin
                    login @user
                    redirect_to "/admin"
                else
                    login @user
                    redirect_to "/home", notice: "Signed in."
                end
            else
                flash.now[:alert] = "Incorrect email or password."
                render :new, status: :unprocessable_entity
            end
        rescue
            flash[:error] = "User credentials does not exist!"
            redirect_to "/login"
        end
    end
  
    def destroy
      logout
      redirect_to "/login", notice: "Signed out."
    end
  
    def new
    end
    
end
