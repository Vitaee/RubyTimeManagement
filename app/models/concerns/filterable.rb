module Filterable
    extend ActiveSupport::Concern
    
    module ClassMethods
        
        def filter(filtering_params)
            results = self.where(nil)
            filtering_params.delete_if{|key,value| value.blank? || value=="admin" || value=="index"}
            
            # get user object if username entered
            if filtering_params['username']
                @user = User.lower_username(filtering_params['username'].downcase)
                filtering_params['username'] = @user
            end
            
            # convert string date to date object
            if filtering_params['start_date']
                filtering_params['start_date'] = Date.strptime(filtering_params['start_date'], "%Y-%m-%d")
                filtering_params['end_date'] =  Date.strptime(filtering_params['end_date'], "%Y-%m-%d")
            end

            # create group by weekly or monthly
            if filtering_params['group_by'] 
                if filtering_params['group_by'] == 'weekly'
                    filtering_params['group_by'] = 'start_date BETWEEN ? AND ?', DateTime.now.beginning_of_week, DateTime.now.end_of_week
                else
                    filtering_params['group_by'] = 'start_date BETWEEN ? AND ?', DateTime.now.beginning_of_month, DateTime.now.end_of_month
                end
            end

            # create dynamic string to call filtering function dynamically.
            dynamic_string = ""
            
            filtering_params.each do |key, value|
                dynamic_string += "#{key}_"
            end


            results = results.public_send("by_#{dynamic_string.chomp("_")}", filtering_params)            
            results
        end
    end
end