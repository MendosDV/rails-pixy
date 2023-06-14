class Visit < ApplicationRecord
  belongs_to :profile

  def self.today
    where(date: DateTime.current.beginning_of_day..DateTime.current.end_of_day)
  end

  def self.week
    where(date: 7.days.ago.beginning_of_day..DateTime.current.end_of_day)
  end
end
