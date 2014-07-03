class Activity < ActiveRecord::Base
  belongs_to :user
  before_validation :geocode, if: :location_changed?
  validate :address_geolocation
  # geocoded_by :ip_address,
  #   :latitude => :latitude, :longitude => :longitude
  # after_validation :geocode
  reverse_geocoded_by :latitude, :longitude


  geocoded_by :location do |obj, results|
    if geo = results.first
      obj.latitude = geo.latitude
      obj.longitude = geo.longitude
      obj.location = geo.address
    else
      obj.location = nil
    end
  end

  def address_geolocation 
    errors.add(:location, "must be valid") if self.location.nil?
  end

  scope :on_now, -> { where("(arrival_date < ? AND departure_date > ?)", DateTime.now, DateTime.now )}

  # Check if a given interval overlaps this interval    
  def overlaps?(other)
    (arrival_date - other.departure_date) * (other.arrival_date - departure_date) >= 0
  end

  # Return a scope for all interval overlapping the given interval, including the given interval itself
  scope :overlapping, lambda { |interval| {
    :conditions => ["(DATEDIFF(arrival_date, ?) * DATEDIFF(?, departure_date)) >= 0", interval.departure_date, interval.arrival_date]
  }}

  scope :current_and_future, -> { where("(departure_date > ?)", DateTime.now)}
# scope :user, where(gender: 'female')

end
