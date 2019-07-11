require 'rails_helper'

RSpec.describe Space, type: :model do
  it {should belong_to(:airline)}

  it {should validate_presence_of(:departure)}
  it {should validate_presence_of(:departure_time)}
  it {should validate_presence_of(:destination)}
  it {should validate_presence_of(:arrival_time)}
  it {should validate_presence_of(:airline_id)}
end
