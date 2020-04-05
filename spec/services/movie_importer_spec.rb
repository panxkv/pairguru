require "rails_helper"

RSpec.describe MovieImporter, type: :service do
  describe "#call" do
    let(:movie) { create(:movie) }

    let(:body_response) do
      { data:
          { attributes:
              { title: movie.title.to_s,
                plot: "My super plot",
                poster: "/big_poster.jpg" } } }.to_json
    end

    let(:movie_data) do
      OpenStruct.new(title: movie.title.to_s, plot: "My super plot", poster: "/big_poster.jpg")
    end

    let(:uri_template) do
      Addressable::Template
        .new "https://pairguru-api.herokuapp.com/api/v1/movies/#{movie.title.gsub(' ', '%20')}"
    end

    context "when movie was found in API" do
      before do
        stub_request(:get, uri_template)
          .with(headers: { "Accept" => "*/*" }).to_return(body: body_response)
      end

      it "calls api with specific url" do
        described_class.call(movie.title)
        WebMock.should have_requested(:get, uri_template).once
      end

      it "returns movie data" do
        expect(described_class.call(movie.title)).to eq movie_data
      end
    end

    context "when movie was not found in API" do
      before do
        stub_request(:get, uri_template)
          .with(headers: { "Accept" => "*/*" }).to_return(status: [404, "Not found"])
      end

      it "calls api with specific url and return movie data" do
        expect(described_class.call(movie.title)).to eq nil
      end
    end
  end
end
