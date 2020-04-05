# frozen_string_literal: true

require "rails_helper"

describe API::V1::Movies::Show, type: :request do
  describe "GET /api/v1/movies/:id" do
    let(:movie) { create(:movie) }
    let(:params) { {} }

    subject(:request) do
      get "/api/v1/movies/#{movie.id}", params: params
      response
    end

    its(:status) { is_expected.to eq 200 }

    context "when user pass no params" do
      describe "returns movie without genre" do
        subject do
          request.parsed_body.symbolize_keys
        end

        its([:id]) { is_expected.to eq movie.id }
        its([:title]) { is_expected.to eq movie.title }
      end
    end

    context "when user pass with_genre params" do
      let(:params) { { with_genre: true } }
      describe "returns movie with genre" do
        subject(:body) do
          request.parsed_body.with_indifferent_access
        end

        its(["id"]) { is_expected.to eq movie.id }
        its(["title"]) { is_expected.to eq movie.title }
        its(["genre"]) do
          is_expected.to match ({ "id": movie.genre.id,
                                  "name": movie.genre.name,
                                  "movies_count": movie.genre.movies.count })
        end
      end
    end
  end
end
