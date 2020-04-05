module API
  module Entities
    class Movie < Grape::Entity
      expose :id
      expose :title
      expose :genre, with: API::Entities::Genre, if: lambda { |_i, opt| opt[:with_genre] }
    end
  end
end
