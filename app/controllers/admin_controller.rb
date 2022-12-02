class AdminController < ApplicationController
    before_action :redirect_if_not_admin
    def index
        
        @user_count = User.all.where("id != ?", current_user.id)
        if params[:username] || params[:time_type] || params[:start_date] || params[:end_date]
            
            param = give_me_filter_params
            @all_users = nil
            q = nil
            @user = nil
            
            if param['username']
                @user = User.lower_username(param['username'].downcase)
            end

            if param['group_by']
                if param['group_by'] == 'monthly'
                    q = 'start_date BETWEEN ? AND ?', DateTime.now.beginning_of_month, DateTime.now.end_of_month
                else
                    q = 'start_date BETWEEN ? AND ?', DateTime.now.beginning_of_week, DateTime.now.end_of_week
                end
            end

            if  param['username'] && param['time_type'] && param['start_date'] && param['end_date']
                 
                @pagy, @all_users = pagy( TimeRecord.by_user_type_dates(param['start_date'].beginning_of_day..param['end_date'].end_of_day, 
                @user, param['time_type']))

            elsif param['username'] && param['time_type'] && param['group_by'] && @all_users.blank?

                @pagy, @all_users = pagy( TimeRecord.where(q).by_user_type(@user, param['time_type']) )

            elsif param['time_type'] && param['group_by'] && @all_users.blank?

                @pagy, @all_users = pagy(TimeRecord.where(q).where(time_type:param['time_type']) )
 
            elsif param['username'] && param['group_by'] && @all_users.blank?

                @pagy, @all_users = pagy( TimeRecord.where(q).where(user_id:@user) )

            elsif param['username'] && param['start_date'] && param['end_date'] && @all_users.blank? 
                
                @pagy, @all_users = pagy(TimeRecord.by_user_dates(@user, 
                param['start_date'].beginning_of_day..param['end_date'].end_of_day))
            
            elsif param['time_type'] && param['start_date'] && param['end_date'] && @all_users.blank? 
                
                @pagy, @all_users = pagy( TimeRecord.where(start_date: param['start_date'].beginning_of_day..param['end_date'].end_of_day, 
                time_type: param['time_type']) )

            elsif param['start_date'] && param['end_date'] && @all_users.blank?

                @pagy, @all_users = pagy( TimeRecord.where(start_date: param['start_date'].beginning_of_day..param['end_date'].end_of_day) )

            elsif param['time_type'] && param['username'] && @all_users.blank?
                @pagy, @all_users = pagy( TimeRecord.by_user_type(@user, param['time_type']) )
                

            elsif param['time_type'] && @all_user.blank?
                @pagy, @all_users = pagy( TimeRecord.where(time_type: params[:time_type] ).order(start_date: :desc) )
            
            elsif param['username'] &&  @all_users.blank?
                
                @pagy, @all_users = pagy( TimeRecord.where(user_id: @user ).order(start_date: :desc) )

            elsif param['group_by'] && @all_users.blank?

                @pagy, @all_users = pagy( TimeRecord.where(q).order(start_date: :desc) )

            else
                @pagy, @all_users = pagy( TimeRecord.all.order(start_date: :desc) )
            end
        else
            if @all_users.blank?
                @pagy, @all_users = pagy(TimeRecord.all.order(start_date: :desc))
            end
    
        end
    end

    
    private

    def give_me_filter_params
        params.delete_if{|key,value| value.blank? || value=='---' || value=="Search"}
        
        if params['start_date']
            params['start_date'] =  Date.strptime(params['start_date'], "%Y-%m-%d")
            params['end_date'] = Date.strptime(params['end_date'], "%Y-%m-%d")
        end

        return params
    end
end
