class Activity < ActiveRecord::Base
  belongs_to :user


  # Check if a given interval overlaps this interval    
  def overlaps?(other)
    (arrival_date - other.departure_date) * (other.arrival_date - departure_date) >= 0
  end

  # Return a scope for all interval overlapping the given interval, including the given interval itself
  scope :overlapping, lambda { |interval| {
    :conditions => ["(DATEDIFF(arrival_date, ?) * DATEDIFF(?, departure_date)) >= 0", interval.departure_date, interval.arrival_date]
  }}


# scope :user, where(gender: 'female')

end
