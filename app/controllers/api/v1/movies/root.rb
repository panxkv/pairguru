module API
  module V1
    module Movies
      class Root < Grape::API
        resource :movies do
          mount Index
          mount Show
        end
      end
    end
  end
end
