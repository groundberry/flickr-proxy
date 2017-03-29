require 'sinatra'
require 'faraday'
require 'dotenv/load'

before do
  response.headers['Access-Control-Allow-Origin'] = ENV['ORIGIN']
end

get '/' do
  query = params[:query]
  num = params[:num] || 50
  page = params[:page] || 1

  url = 'https://api.flickr.com/services/rest/?' \
        "api_key=#{ENV['API_KEY']}&" \
        'method=flickr.photos.search&' \
        'format=json&' \
        'nojsoncallback=1&' \
        "per_page=#{num}&" \
        "page=#{page}&" \
        "text=#{query}"

  response = Faraday.get(url)
  response.body
end
