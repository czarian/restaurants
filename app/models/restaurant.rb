class Restaurant < ActiveRecord::Base
  has_many :comments
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  def to_s
    name
  end
end
