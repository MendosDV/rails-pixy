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
        puts params[:profile_id]
        current_profile = Profile.find(params[:profile_id])
        current_user.profiles.each do |profile|
          profile.update(selected: false)
        end
        current_profile.update(selected: true)
        current_user.update(current_category_id: current_profile.category_id)
        render json: { content: "ok" }
        head :ok
      end
    end
  end
end
