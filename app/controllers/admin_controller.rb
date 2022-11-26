class AdminController < ApplicationController
    def index
        @user = User.find_by(username: params[:username])
        if @user
            @all_users = TimeRecord.where(user_id: @user.id ).paginate(:page => params[:page], :per_page => 2)  
        else
            @all_users = TimeRecord.all.paginate(:page => params[:page], :per_page => 2)
        end
    end

end
