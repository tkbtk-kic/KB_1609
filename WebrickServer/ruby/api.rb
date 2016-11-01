require 'mysql2'
require 'sinatra'
require 'json'

set :bind, '0.0.0.0'

get '/show' do
  article={
      id: 1,
      title: "API Test",
      content: "get test"
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