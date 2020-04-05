# frozen_string_literal: true

require "rails_helper"

describe API::V1::Movies::Index, type: :request do
  describe "GET /api/v1/movies" do
    let!(:movies) { create_list(:movie, 10) }
    let(:params) { {} }

    subject(:request) do
      get "/api/v1/movies", params: params
      response
    end

    its(:status) { is_expected.to eq 200 }

    context "when user no pass params" do
      describe "returns movie without genre" do
        subject(:body) do
          request.parsed_body.map(&:symbolize_keys)
        end

        it "returns collection including id and title" do
          body.each do |movie|
            expect(body).to include_hash_matching(id: movie[:id], title: movie[:title])
          end
        end

        it "returns collection without genre" do
          body.each do |movie|
            expect(body).to_not include_hash_matching(genre: movie[:genre])
          end
        end
      end
    end

    context "when user pass true with_genre params" do
      let(:params) { { with_genre: true } }
      subject(:body) do
        request.parsed_body.map(&:symbolize_keys)
      end

      it "returns collection with genre" do
        body.each do |movie|
          expect(body)
            .to include_hash_matching(id: movie[:id], title: movie[:title], genre: movie[:genre])
        end
      end
    end
  end
end
