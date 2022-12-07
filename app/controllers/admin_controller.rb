class AdminController < ApplicationController
    before_action :redirect_if_not_admin
    def index        
        @user_count = User.all.where("id != ?", current_user.id)

        if params[:username] || params[:time_type] || params[:start_date] || params[:end_date] || params[:group_by]

            param = give_me_filter_params
            @pagy, @all_users = pagy(TimeRecord.filter(param))
        
        else
        
            @pagy, @all_users = pagy(TimeRecord.all.order(start_date: :desc))
        
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
