# frozen_string_literal: true

module API
  class Base < Grape::API
    rescue_from ActiveRecord::RecordNotFound do |exception|
      error!({ errors: [{ source: exception.model.downcase, message: exception.message }] }, 404)
    end

    mount API::V1::Base
  end
end
