require 'json'

json_file_path = 'one_tweet.json'

json_data = open(json_file_path) do |io|
  JSON.load(io)
end

p json_data["entities"]["urls"][0]["display_url"][0, 12] == "swarmapp.com"