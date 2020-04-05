module API
  module Entities
    class Genre < Grape::Entity
      expose :id
      expose :name
      expose :movies_count

      private

      def movies_count
        object.movies.count
      end
    end
  end
end
