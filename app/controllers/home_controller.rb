class HomeController < ApplicationController

    def create
        @timerecord = current_user.time_records.create(timerecord_params)

        if @timerecord.save
            redirect_to "/home"
        else
            redirect_to "/home"
        end
    end

    def destroy
        @timerecord = current_user.time_records.delete(params[:id])
        redirect_to "/home"
    end

    def new
        @user = current_user
        @timerecord = TimeRecord.new
        @user_time_records = User.find(current_user.id).time_records
    end

    def update
        @timerecord = current_user.time_records.find(params[:id]).update(end_date: Time.now)

        redirect_to "/home"
    end

    def show
        @user = current_user
        @timerecord = @user.time_records.find(params[:id])
    end

    

    private

    def timerecord_params
        params.require(:time_record).permit(:start_date, :end_date, :comment, :time_type)
    end
end
