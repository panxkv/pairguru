require "rails_helper"

RSpec.describe MoviesController, type: :controller do
  let(:movies) { create_list(:movie, 10) }

  describe "GET #index" do
    before do
      get :index
    end

    it "returns http success" do
      expect(response).to be_successful
    end

    it "returns movies" do
      expect(assigns(:movies)).to match_array(movies)
    end
  end

  describe "GET #show" do
    before do
      get :show, params: { id: movies.first.id }
    end

    it "returns http success" do
      expect(response).to be_successful
    end

    it "returns movie" do
      expect(assigns(:movie)).to eq movies.first
    end
  end

  describe "GET #movie_data" do
    let(:api_movie_struct) do
      OpenStruct.new(title: "My awesome title", plot: "My super plot", poster: "/big_poster.jpg")
    end

    before do
      allow_any_instance_of(MovieImporter).to receive(:call).and_return(api_movie_struct)
      get :movie_data, params: { id: movies.first.id }
    end

    it "returns http success" do
      expect(response).to be_successful
    end

    it "returns movie data template" do
      expect(response).to render_template(partial: "_movie_data")
    end

    it "returns movie and movie data" do
      expect(assigns(:movie)).to eq movies.first
      expect(assigns(:movie_data)).to eq api_movie_struct
    end
  end

  describe "GET #movie_poster" do
    let(:api_movie_struct) do
      OpenStruct.new(title: "My awesome title", plot: "My super plot", poster: "/big_poster.jpg")
    end

    before do
      allow_any_instance_of(MovieImporter).to receive(:call).and_return(api_movie_struct)
      get :movie_poster, params: { id: movies.first.id }
    end

    it "returns http success" do
      expect(response).to be_successful
    end

    it "returns movie poster template" do
      expect(response).to render_template(partial: "_movie_poster")
    end

    it "returns movie and movie data" do
      expect(assigns(:movie)).to eq movies.first
      expect(assigns(:movie_data)).to eq api_movie_struct
    end
  end
end
