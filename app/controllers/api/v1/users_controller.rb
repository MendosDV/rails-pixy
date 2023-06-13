require "cloudinary"
include CloudinaryHelper

module Api
  module V1
    class UsersController < Api::V1::BaseController
      def index
        render json: {
          user: current_user,
          profiles: current_user.profiles.map do |profile|
            {
              infos: profile,
              picture: cl_image_tag(profile.picture.key)
            }
          end

        }
      end

      def change_category
        current_user.update(current_category_id: params[:category_id])
        render json: { content: "ok" }
        head :ok
      end
    end
  end
end
