require 'sinatra'

set :port, 8080
set :public_folder, "public"
set :views, "views"

tags = Hash.new(0)


get '/' do 
    erb :index
end

post '/create' do
	url = params[:url] 
	colour = "%06x" % (rand * 0xffffff)

	if url.index("http") != 0
		url = "http://" + url
	end

	if url.include? "www." 
		url.slice! "www."
	end


	if tags[url] == 0
		hashmap = {url => colour}
		tags.merge!(hashmap)
		html_button = "<button style='width:100;height:100;background-color:#{colour}'"  + 'onClick="window.location='+ "'" + url + "'"+ '"' + "><b>##{colour}</b></button>"
	else
		colour = tags[url]
		html_button = "<button style='width:100;height:100;background-color:#{colour}'"  + 'onClick="window.location='+ "'" + url + "'"+ '"' + "><b>##{colour}</b></button>"
	end

	erb :create, :locals => {:button => html_button, :url => url}
end 