class Api::V1::VulgaritiesController < Api::V1::BaseController
  respond_to :json
  # Cette action récupère dans les params le body/ text, applique replace_vulgarities dessus et renvoie le JSON
  def process_dom
    dom = params[:dom]

    unless dom
      return render json: { error: "Une erreur s'est produite lors du traitement du DOM." }, status: :unprocessable_entity
    end

    @replaced_text = replace_vulgarities(dom: dom)
    ap @replaced_text
    render json: { data: @replaced_text }
  end

  private

  # Cette action stock notre hash dans vulgarities
  def replace_vulgarities(dom:)
    words = {
      "connard" => {
        "replace" => "personne désagréable",
        "language" => "fr",
        "category" => "Grossier",
        "description" => "Cette expression ..."
      }
    }

    words.each do |word, hash|
      new_word = hash["replace"]
      dom.gsub!(word, "ef#{new_word}")
    end
    dom
  end
end
