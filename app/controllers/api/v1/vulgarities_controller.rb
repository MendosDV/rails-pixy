require "nokogiri"
require "json"

module Api
  module V1
    class VulgaritiesController < Api::V1::BaseController
      respond_to :json
      # Cette action récupère dans les params le body/ text, applique replace_vulgarities dessus et renvoie le JSON
      def process_dom
        body = params[:body]
        head = params[:head]
        hash = params[:visitedSite]

        @visit = Visit.create!(title: hash[:title], url: hash[:url], date: DateTime.current, profile: current_user.profiles.find_by(selected: true))

        unless body
          return render json: { error: "Une erreur s'est produite lors du traitement du DOM." }, status: :unprocessable_entity
        end

        @replaced_body = replace_vulgarities_body(dom: body)
        @replaced_head = replace_vulgarities_head(dom: head)

        render json: { modifiedBODY: @replaced_body, modifiedHEAD: @replaced_head }
      end

      private

      # Cette action stock notre hash dans vulgarities
      def replace_vulgarities_body(dom:)
        category = Category.where(id: current_user.current_category_id).first || Category.first
        json_file = File.read(Rails.root.join('public', 'vulgarities.json'))
        hash = JSON.parse(json_file)
        count = 0

        hash.each do |key, value|
          case category.name
          when "Faible"
            dom.gsub!(/(#{key})(?!([^<]+)?>)/i) do |match|
              count += 1
              "<pixy data-level='low'>
                #{key}
              </pixy>"
            end
          when "Modéré"
            dom.gsub!(/(#{key})(?!([^<]+)?>)/i) do |match|
              count += 1
              "<pixy data-word='#{key}'
                data-level='medium'
                data-description='#{value['description']}'>
                  #{value['replace']}
                  <pixy-explication style='position: absolute; display: none;'>
                    <pixy-dico>
                      <img src='https://3dicons.co/colored.png' width='48vh'>
                      <dico>Dico des gros mots</dico>
                    </pixy-dico>
                    <pixy-word>#{key.capitalize}</pixy-word>
                    <pipe> | </pipe>
                    <pixy-category>#{value['category']}</pixy-category><br>
                    <pixy-description>#{value['description']}</pixy-description>
                  </pixy-explication>
                </pixy>"
              end

          when "Elevé"
            dom.gsub!(/(#{key})(?!([^<]+)?>)/i) do |match|
              count += 1
              "<pixy data-level='high' >
                #{value['replace']}
              </pixy>"
            end
          end
        end

        @visit.update(words_changed: count)
        dom += "<pixy-warning>
                  <warning>Avertissement</warning><br><br>
                  <text>Cette page contient du contenu à caractère vulgaire,
                  sexuel, discriminant ou dangereux.
                  </text>
                </pixy-warning>"
        dom
      end

      def replace_vulgarities_head(dom:)
        json_file = File.read(Rails.root.join('public', 'vulgarities.json'))
        hash = JSON.parse(json_file)

        hash.each do |key, value|
          dom.gsub!(/(#{key})(?!([^<]+)?>)/i) do |match|
            value['replace']
          end
        end

        dom
      end
    end
  end
end
