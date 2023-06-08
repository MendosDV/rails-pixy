require "nokogiri"

class Api::V1::VulgaritiesController < Api::V1::BaseController
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
      dom.gsub!(word, hash[word.downcase][:replace]) if hash[word.downcase]
    end

    # words.each do |word, hash|
    #   word = word.downcase
    #   new_word = hash[:replace]
    #   dom.gsub!(word, new_word)
    # end
    puts dom
    dom
  end

  def retrieve_words_from_dom(dom)
    doc = Nokogiri::HTML(dom)
    words = []

    doc.traverse do |node|
      words.concat(node.text.strip.split) if node.text?
    end

    words
  end
end
