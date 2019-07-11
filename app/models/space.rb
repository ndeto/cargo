class Space < ApplicationRecord
  belongs_to :airline

  validates_presence_of :airline_id
  validates_presence_of :departure
  validates_presence_of :departure_time
  validates_presence_of :destination
  validates_presence_of :arrival_time
end
