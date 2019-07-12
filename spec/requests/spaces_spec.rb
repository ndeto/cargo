require 'rails_helper'

RSpec.describe "Spaces", type: :request do

  let!(:airlines) {create(:airline)}
  let(:airline_id) {airlines.id}
  let!(:spaces) { create_list(:space, 20, airline_id: airline_id) }
  let(:space_id) {spaces.first.id}
  #Get all spaces

  describe "GET /spaces" do

    before {get "/airlines/#{airline_id}/spaces" }

    context "It retrieves the records" do

      it "gets available spaces" do
        expect(response).to have_http_status(200)
      end

      it "returns the right number of spaces" do
        expect(json.size).to eq(20)
      end
    end
  end

  #Retrieving specific space

  describe "GET /airlines/:airline_id/spaces/:space_id" do

    before {get "/airlines/#{airline_id}/spaces/#{space_id}"}

    context "When the record exists" do

      it "returns the airline" do
        expect(json).not_to be_empty
        expect(json['id']).to eq(space_id)
      end

      it "returns status 200" do
        expect(response).to have_http_status(200)
      end
    end


    context "when the record doesn't exist" do

      let(:space_id) { 128 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Space/)
      end

    end
  end

  # Creating records

  describe "POST /airlines/:airline_id/spaces/" do

    let(:valid_attributes) {{departure: "Nairobi", destination:"Jo'Burg",departure_time: "2019-07-09 13:52:19" , arrival_time:"2019-07-09 13:52:19", airline_id:airline_id}}

    context "when the request is valid" do

      before {post "/airlines/#{airline_id}/spaces", params: valid_attributes}

      it "creates a space" do
        expect(json['departure']).to eq('Nairobi')
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    # When invalid parameters are supplied

    context "when the request is invalid" do

      before {post "/airlines/#{airline_id}/spaces", params: {foobar: "foobar"}}

      it "returns error 422" do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/can't be blank/)
      end

    end


    # Update the record

    context "Update an airline" do

      before { put "/airlines/#{airline_id}/spaces/#{space_id}", params: {departure:"Kampala"}}

      it "returns status 204" do
        expect(response).to have_http_status(204)
      end

      it 'updates the record' do
        expect(response.body).to be_empty
      end
    end
  end

=begin

  describe 'DELETE /todos/:id' do

    before { delete "/airlines/#{airline_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
=end
  end

