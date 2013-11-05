require 'nokogiri'
require 'open-uri'

module Helpers
  def definition(word)
    begin
      url = URI.encode("http://www.wordreference.com/definicion/#{word}")
      doc = Nokogiri::HTML(open(url))
      doc.css("div#article ol li")
    rescue Exception => e
      "Not found"
    end
  end
end
