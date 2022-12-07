module Filterable
    extend ActiveSupport::Concern
    
    module ClassMethods
        
        def filter(filtering_params)
            results = self.where(nil)
            filtering_params.delete_if{|key,value| value.blank? || value=='---' || value=="Search" || value=="admin" || value=="index"}
            
            if filtering_params['username']
                @user = User.lower_username(filtering_params['username'].downcase)
                filtering_params['username'] = @user
            end
            
            dynamic_string = ""
            
            filtering_params.each do |key, value|
                dynamic_string += "#{key}_"
            end

            results = results.public_send("by_#{dynamic_string.chomp("_")}", filtering_params)            
            results
        end
    end
end