class TimeRecord < ApplicationRecord
    belongs_to :user

    scope :by_user_type_dates, ->(date, user, type) { where(start_date: date, user_id: user,
    time_type:type) }

    scope :by_user_type, ->(user, type) { where(user_id: user, time_type: type) }

    scope :by_user_dates, ->(user, date) { where(user_id: user, start_date: date) }

end
