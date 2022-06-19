module Api
  module V1
    class ApiController < ActionController::API
      # Make ActiveStorage aware of the current host (used in url helpers)
      include ActiveStorage::SetCurrent
    end
  end
end