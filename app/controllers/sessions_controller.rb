class SessionsController < ApplicationController
    before_action :redirect_if_authenticated, only: [:create, :new]
    
    def create
        @user = User.find_by(email: params[:user][:email].downcase)
        if @user.authenticate(params[:user][:password])
            login @user
            redirect_to "/home", notice: "Signed in."
        
        else
            flash.now[:alert] = "Incorrect email or password."
            render :new, status: :unprocessable_entity
        end
    end
  
    def destroy
      logout
      redirect_to "/login", notice: "Signed out."
    end
  
    def new
    end
    
end
