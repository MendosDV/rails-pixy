require "nokogiri"

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
        hash = {
          "connard" => {
            replace: "personne désagréable",
            language: "fr",
            category: "Grossier",
            description: "Cette expression ..."
          },
          "bordel à cul" => {
            replace: "grand désordre",
            language: "fr",
            category: "Grossier",
            description: "Cette expression désigne un grand désordre."
          }
        }

        words = retrieve_words_from_dom(dom)

        words.each do |word|
          if hash[word.downcase]
            dom.gsub!(word, hash[word.downcase][:replace])
          end
        end
        puts dom
        dom
      end

      def retrieve_words_from_dom(dom)
        doc = Nokogiri::HTML(dom)
        array = []

        doc.traverse do |node|
          if node.text?
            sentence = node.text.strip
            words = sentence.split
            (0...words.length).each do |start_index|
              (start_index...words.length).each do |end_index|
                combination = words[start_index..end_index].join(" ")
                array << combination
              end
            end
          end
        end

        array
      end
    end
  end
end
