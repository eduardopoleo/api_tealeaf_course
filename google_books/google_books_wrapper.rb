require "json"
require "faraday"

class QueryUrlConstructor
  attr_reader :url

  def initialize(search_term)
    raise "No searh term provided" if search_term.length < 1
    @url = "https://www.googleapis.com/books/v1/volumes?q=" + search_term
  end
end

class ResponseParser
  attr_reader :body

  def initialize (response)
    @body = JSON.load(response.body)
  end

  def parse
    body["items"].map do |book|
     info = book["volumeInfo"]
     {authors: info["authors"], title: info["title"]}
    end
  end
end

class HttpClient
  attr_reader :client

  def initialize(client=Faraday.new)
    @client = client
  end

  def make_reponse(url)
    client.get(url)
  end
end

def get_books_information(search_term)
  url = QueryUrlConstructor.new(search_term).url
  gooogle_books_response = HttpClient.new().make_reponse(url)
  books_info = ResponseParser.new(gooogle_books_response).parse
end

puts "Enter the name (partial name) for the book you want"
search_term = gets.chomp

books_info = get_books_information(search_term)
puts books_info
