class HomeController < ApplicationController

    def show 
        @user = current_user
    end

    def new
        @timerecord = TimeRecord.new
    end
end
