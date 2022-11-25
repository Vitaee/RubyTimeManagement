class HomeController < ApplicationController

    def create
        @user = current_user
        @timerecord = @user.time_records.create(timerecord_params)

        if @timerecord.save
            redirect_to "/home"
        else
            redirect_to "/home"
        end
    end

    def destroy
        @user = current_user
        @timerecord = @user.time_records.delete(params[:id])
        redirect_to "/home"
    end

    def new
        @user = current_user
        @timerecord = TimeRecord.new
        @user_time_records = User.find(current_user.id).time_records
    end

    

    private

    def timerecord_params
        params.require(:time_record).permit(:start_date, :end_date, :comment, :time_type)
    end
end
