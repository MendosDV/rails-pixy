module Api
  module V1
    class UsersController < Api::V1::BaseController
      def index
        render json: { user: current_user, profiles: current_user.profiles, categories: current_user.profiles.map(&:category_id) }
      end
    end
  end
end
