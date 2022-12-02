class HomeController < ApplicationController

    def create
        @timerecord = current_user.time_records.create(timerecord_params)

        unless @timerecord.save
            redirect_to "/home"
        end

        redirect_to "/home"

    end

    def destroy
        @timerecord = current_user.time_records.delete(params[:id])
        redirect_to "/home"
    end

    def new
        begin
            if current_user
                if current_user.is_admin
                    redirect_to "/admin"
                end
            end
                
            @timerecord = TimeRecord.new
            @user_time_records = current_user.time_records
        rescue
            redirect_to "/login"
        end
    end

    def update
        @timerecord = current_user.time_records.find(params[:id]).update(end_date: Time.now)

        redirect_to "/home"
    end

    def show
        begin
            @user = current_user
            @timerecord = @user.time_records.find(params[:id])
        rescue
            @timerecord = TimeRecord.find(params[:id])
        end
    end
    

    private

    def timerecord_params
        params.require(:time_record).permit(:start_date, :end_date, :comment, :time_type)
    end
end
