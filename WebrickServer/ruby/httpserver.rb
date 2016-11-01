require 'sinatra'

s=HTTPServer.new(
	:port => 8000,
	:DocumentRoot => File.join(Dir::pwd, "html")
)
trap("INT"){s.shutdown}
s.start
