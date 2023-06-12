require "nokogiri"
require "json"

module Api
  module V1
    class VulgaritiesController < Api::V1::BaseController
      respond_to :json
      # Cette action récupère dans les params le body/ text, applique replace_vulgarities dessus et renvoie le JSON
      def process_dom
        dom = params[:dom]

        unless dom
          return render json: { error: "Une erreur s'est produite lors du traitement du DOM." }, status: :unprocessable_entity
        end

        @replaced_text = replace_vulgarities(dom: dom)
        render json: { modifiedDOM: @replaced_text }
      end

      private

      # Cette action stock notre hash dans vulgarities
      def replace_vulgarities(dom:)

        json_file = File.read(Rails.root.join('public', 'vulgarities.json'))
        hash = JSON.parse(json_file)
        hash.each do |key, value|
          dom.gsub!(/#{key}/i, "<pixy data-word='#{key}' data-description='#{value['description']}'>
            #{value['replace']}
        </pixy>")

        end
        dom += "<pixy-explication style='position: absolute; display: none;> </pixy-explication>"
        dom
      end
    end
  end
end
