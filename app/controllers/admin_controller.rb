class AdminController < ApplicationController
    before_action :redirect_if_not_admin
    def index
        @user_count = User.all.where("id != ?", current_user.id)
        if params[:username] || params[:time_type]
            if params[:time_type].length >= 1 && params[:username].length >= 1
                @user = User.where("lower(username) like ?", "%#{params[:username].downcase}%")  
                @all_users = TimeRecord.where(user_id: @user, time_type: params[:time_type] ).paginate(:page => params[:page], :per_page => 3) 
            
            elsif params[:time_type].length >= 1 && @all_user.blank?
                @all_users = TimeRecord.where(time_type: params[:time_type] ).paginate(:page => params[:page], :per_page => 3)  
            
            elsif params[:username].length >= 1 &&  @all_users.blank?
                @user = User.where("lower(username) like ?", "%#{params[:username].downcase}%")  
                @all_users = TimeRecord.where(user_id: @user ).paginate(:page => params[:page], :per_page => 3) 

            else
                @all_users = TimeRecord.all.paginate(:page => params[:page], :per_page => 3)
            end
        else
            if @all_user.blank?
                @all_users = TimeRecord.all.paginate(:page => params[:page], :per_page => 3)
            end
    
        end
    end
end
