class AdminController < ApplicationController
    before_action :redirect_if_not_admin
    def index
        
        @user_count = User.all.where("id != ?", current_user.id)
        if params[:username] || params[:time_type] || params[:start_date] || params[:end_date]
            param = give_me_filter_params
            @all_users = nil
            q = nil
            
            if param['group_by']
                if param['group_by'] == 'monthly'
                    q = 'created_at BETWEEN ? AND ?', DateTime.now.beginning_of_month, DateTime.now.end_of_month
                else
                    q = 'created_at BETWEEN ? AND ?', DateTime.now.beginning_of_week, DateTime.now.end_of_week
                end
            end


            if  param['username'] && param['time_type'] && param['start_date'] && param['end_date']
                @user = User.lower_username(param['username'].downcase) 

                start_date = Date.strptime(param['start_date'], "%Y-%m-%d")
                end_date = Date.strptime(param['end_date'],"%Y-%m-%d")

                @all_users = TimeRecord.where(start_date: start_date.beginning_of_day..end_date.end_of_day, user_id:@user,
                time_type:param['time_type'])
                .paginate(:page => params[:page], :per_page => 5)

            elsif param['username'] && param['time_type'] && param['group_by'] && @all_user.blank?
                @user = User.lower_username(param['username'].downcase) 

                @all_users = TimeRecord.where(q).where(time_type:param['time_type'], user_id:@user)
                .paginate(:page => params[:page], :per_page => 5)

            elsif param['time_type'] && param['group_by'] && @all_users.blank?

                @all_users = TimeRecord.where(q).where(time_type:param['time_type'])
                .paginate(:page => params[:page], :per_page => 5)
 
            elsif param['username'] && param['group_by'] && @all_users.blank?
                @user = User.lower_username(param['username'].downcase) 

                @all_users = TimeRecord.where(q).where(user_id:@user)
                .paginate(:page => params[:page], :per_page => 5)  

            elsif param['username'] && param['start_date'] && param['end_date'] && @all_users.blank? 
                @user = User.lower_username(param['username'].downcase)
                
                start_date = Date.strptime(param['start_date'], "%Y-%m-%d")
                end_date = Date.strptime(param['end_date'],"%Y-%m-%d")
                
                @all_users = TimeRecord.where(start_date: start_date.beginning_of_day..end_date.end_of_day, user_id:@user)
                .paginate(:page => params[:page], :per_page => 5)
            
            elsif param['time_type'] && param['start_date'] && param['end_date'] && @all_users.blank? 
                start_date = Date.strptime(param['start_date'], "%Y-%m-%d")
                end_date = Date.strptime(param['end_date'],"%Y-%m-%d")
                
                @all_users = TimeRecord.where(start_date: start_date.beginning_of_day..end_date.end_of_day, time_type: param['time_type'])
                .paginate(:page => params[:page], :per_page => 5)

            elsif param['start_date'] && param['end_date'] && @all_users.blank?
                start_date = Date.strptime(param['start_date'], "%Y-%m-%d")
                end_date = Date.strptime(param['end_date'],"%Y-%m-%d")
                
                @all_users = TimeRecord.where(start_date: start_date.beginning_of_day..end_date.end_of_day)
                .paginate(:page => params[:page], :per_page => 5)

            elsif param['time_type'] && param['username'] && @all_users.blank?
                @user = User.lower_username(param['username'].downcase) 
                @all_users = TimeRecord.where(user_id: @user, time_type: params[:time_type] ).paginate(:page => params[:page], :per_page => 5) 
                

            elsif param['time_type'] && @all_user.blank?
                @all_users = TimeRecord.where(time_type: params[:time_type] ).paginate(:page => params[:page], :per_page => 5)  
            
            elsif param['username'] &&  @all_users.blank?
                @user = User.lower_username(param['username'].downcase)
                @all_users = TimeRecord.where(user_id: @user ).paginate(:page => params[:page], :per_page => 5) 

            elsif param['group_by'] && @all_users.blank?

                @all_users = TimeRecord.where(q)
                .paginate(:page => params[:page], :per_page => 5)

            else
                @all_users = TimeRecord.all.paginate(:page => params[:page], :per_page => 5)
            end
        else
            if @all_user.blank?
                @all_users = TimeRecord.all.paginate(:page => params[:page], :per_page => 5)
            end
    
        end
    end

    
    private

    def give_me_filter_params
        params.delete_if{|key,value| value.blank? || value=='---' || value=="Search"}
        return params
    end
end
