class TimeRecord < ApplicationRecord
    include Filterable

    belongs_to :user

    scope :by_username, -> (param) { where(user_id: param['username'] )}

    scope :by_time_type, -> (param) { where( time_type: param['time_type']) }

    scope :by_group_by, -> (param) { where(param['group_by'])}

    scope :by_time_type_group_by, -> (param) { where(param['group_by']).where(time_type: param['time_type'])}

    scope :by_start_date_end_date, -> ( param ) {where(start_date: param['start_date'].beginning_of_day..param['end_date'].end_of_day)}

    scope :by_time_type_start_date_end_date, -> ( param ) {where(time_type: param['time_type']).where(start_date: param['start_date'].beginning_of_day..param['end_date'].end_of_day)}

    scope :by_username_group_by, -> (param) { where(param['group_by']).where(user_id: param['username'])}

    scope :by_username_time_type_start_date_end_date, -> (param) { where( param['start_date'].beginning_of_day..param['end_date'].end_of_day).where(user_id: param['username'], time_type:param['time_type'])}
    
    scope :by_username_time_type, ->(param) { where(user_id: param['username'], time_type: param['time_type']) }
    
    scope :by_username_time_type_group_by, ->(param) { where(param['group_by']).where(user_id: param['username'], time_type: param['time_type']) }

    scope :by_username_start_date_end_date, ->(param) { where(start_date: param['start_date'].beginning_of_day..param['end_date'].end_of_day).where(user_id: param['username']) }

end
