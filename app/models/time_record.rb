class TimeRecord < ApplicationRecord
    belongs_to :user

    scope :by_user_type_dates, ->(date, user, type) { where(start_date: date, user_id: user,
    time_type:type) }

end
