require 'rails_helper'

RSpec.describe "Airlines", type: :request do

  let!(:airlines) {create_list(:airline, 10)}
  let(:airline_id) {airlines.first.id}


  describe "GET /airlines" do

    before {get '/airlines'}


    it "gets airlines" do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end


  describe "GET /airlines/:id" do

    before {get "/airlines/#{airline_id}"}

    context "When the record exists" do

    it "returns the airline" do
      expect(json).not_to be_empty
      expect(json['id']).to eq(airline_id)
    end

      it "returns status 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record doesn't exist" do

      let(:airline_id) { 100 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Airline/)
      end
    end
  end

  describe "POST /airlines" do

    let(:valid_attributes) {{name:"HighFlyers", website: "www.high-fly.com"}}

    context "when the request is valid" do

      before {post "/airlines", params: valid_attributes}

      it "creates an airline" do
        expect(json['name']).to eq('HighFlyers')
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do

      before {post "/airlines", params: {foobar: "foobar"}}

      it "returns error 422" do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/can't be blank/)
      end

    end

    context "Update an airline" do

      before { put "/airlines/#{airline_id}", params: {name:"High Fly"}}

      it "returns status 204" do
        expect(response).to have_http_status(204)
      end

      it 'updates the record' do
        expect(response.body).to be_empty
      end
    end
  end

  describe 'DELETE /todos/:id' do

    before { delete "/airlines/#{airline_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
