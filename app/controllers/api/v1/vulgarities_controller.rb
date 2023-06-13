require "nokogiri"
require "json"

module Api
  module V1
    class VulgaritiesController < Api::V1::BaseController
      respond_to :json
      # Cette action récupère dans les params le body/ text, applique replace_vulgarities dessus et renvoie le JSON
      def process_dom
        dom = params[:dom]
        hash = params[:visitedSite]

        Visit.create!(title: hash[:title], url: hash[:url], date: DateTime.current, profile_id: Profile.last.id)

        unless dom
          return render json: { error: "Une erreur s'est produite lors du traitement du DOM." }, status: :unprocessable_entity
        end

        @replaced_text = replace_vulgarities(dom: dom)
        render json: { modifiedDOM: @replaced_text }
      end

      private

      # Cette action stock notre hash dans vulgarities
      def replace_vulgarities(dom:)
        category = Category.find(current_user.current_category_id)
        json_file = File.read(Rails.root.join('public', 'vulgarities.json'))
        hash = JSON.parse(json_file)
        count = 0

        hash.each do |key, value|
          case category.name

          when "Faible"
            dom.gsub!(/(#{key})(?!([^<]+)?>)/i) do |match|
            count += 1
           "<pixy data-level='low'>#{key}</pixy>"
          end

          when "Modéré"
            dom.gsub!(/(#{key})(?!([^<]+)?>)/i) do |match|
            count += 1
            "<pixy data-word='#{key}'
                                  data-level='medium'
                                  data-description='#{value['description']}'>
                                    #{value['replace']}
                                    <pixy-explication style='position: absolute; display: none;'>
                                      <pixy-word>#{key.capitalize}</pixy-word><br><br>
                                      <pixy-description>#{value['description']}</pixy-description>
                                    </pixy-explication>
                                  </pixy>"
                                end

          when "Elevé"
            dom.gsub!(/(#{key})(?!([^<]+)?>)/i) do |match|
            count += 1
           "<pixy data-level='high' >
                                    #{value['replace']}
                                    <pixy-explication style='position: absolute; display: none;'>
                                      <pixy-word>#{key.capitalize}</pixy-word><br><br>
                                      <pixy-description>#{value['description']}</pixy-description>
                                    </pixy-explication>
                                  </pixy>"
                                end
          end
        end
        dom
      end
    end
  end
end
