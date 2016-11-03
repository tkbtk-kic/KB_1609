require 'sinatra'
require 'mysql2'
require 'json'


load 'ruby/Geo_Analysis.rb'

set :public_folder, File.dirname(__FILE__) + '/html'
set :bind, '0.0.0.0'

get '/show' do
  article={
      id: 1,
      title: "API Test",
      content: "get test"
  }
  article.to_json
end


get '/hotspot' do
  article={
      id: 1,
      lat: 34.698901,
      lon: 135.193583
  }
  article.to_json
end

post '/edit' do
  body = request.body.read
  # p body
  if body == ''
    status 400
  else
    body.to_json
  end
end

