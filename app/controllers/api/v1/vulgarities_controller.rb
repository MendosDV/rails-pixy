require "nokogiri"
require "json"

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

    json_file = File.read(Rails.root.join('public', 'vulgarities.json'))
    hash = JSON.parse(json_file)
    words = retrieve_words_from_dom(dom)

    words.each do |word|
      if hash[word.downcase]
        all_words_finded = dom.scan(/.*#{word}.*/i)
        all_words_finded.each do |word_finded|
          dom.gsub!(word, "<pixy data-origin='#{word_finded}' class='blur'>#{hash[word.downcase]['replace']}</pixy>")
        end
      end
    end

    # words.each do |word, hash|
    #   word = word.downcase
    #   new_word = hash[:replace]
    #   dom.gsub!(word, new_word)
    # end
    ap dom
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
