require 'sinatra'
require 'mysql2'
require 'json'
load 'ruby/Geo_Analysis.rb'


#### データベースの設定
json_file_path = 'mysql.json'
# 設定読み込み
json_data = open(json_file_path) do |io|
  JSON.load(io)
end
client = Mysql2::Client.new(:socket => json_data["socket"], :username=> json_data["username"], :password =>  json_data["password"], :encording => json_data["encording"], :database => json_data["database"])
# 接続
#### ~~~~~~~~~~~~~~~~~~

set :public_folder, File.dirname(__FILE__) + '/html'
set :bind, '0.0.0.0'

get '/geotest' do
  geo_tags=[]
  results = client.query("select * from test_geo")
  results.each do |row|
    # puts row["lat"].to_s + " & " + row["lon"].to_s
    geo_tags.push([row["lat"],row["lng"]])
  end
  geo_analysis = Geo_Analysis.new(geo_tags)


  # geo_analysis.hot_spots.each do |arr|
  #   # article << {
  #   #     id: arr[:id],
  #   #     coordinates: arr[:coordinates],
  #   #     tweets_coordinates: arr[:tweets_coordinates]
  #   # }
  #   p arr
  # end
  # article.to_json
  p JSON[geo_analysis.hot_spots]
end


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
      lng: 135.193583
  }
  article.to_json
end

post '/edit' do
  body = JSON.parse(request.body.read)
  # この時点ではstring型
  if body == ''
    status 400
  else
    if(!body.keys.include?("statuses"))
      p "error message"
      return status 400
    else
      arr =[]
      body["statuses"].each do |raw|
        article ={
          id: raw["id"],
          lat: raw["geo"]["coordinates"][0],
          lng: raw["geo"]["coordinates"][1],
          datetime: raw["created_at"]
        }
        arr << article
      end
      # p arr
      JSON.pretty_generate(arr)
    end
    #       lat: raw["geo"]["coordinates"][0],
    #       lng: raw["geo"]["coordinates"][1],
    #       datetime: raw["created_at"]
    #   }
    #   arr << article
    # end
    # arr.to_json
    # status 200
    # body.to_json
    # p body.class
    # p body
    # status 200
  end
end

post '/test' do
  body = JSON.parse request.body.read
  # query = "insert into post_test(id, lat, lng)values"

  body.each do |json|
    client.query("insert into post_test(id, lat, lng) values(#{json["id"]}, #{json["lat"]}, #{json["lng"]});")
  end
  status 200
end