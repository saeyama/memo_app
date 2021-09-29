require 'sinatra'
require 'sinatra/reloader'
require 'json'

get '/' do
  redirect to '/memos'
end

get '/memos' do
  @datas = Dir.glob("datas/*").map{|data| File.open(data){|file|JSON.load(file)}}
  erb :index
end

post '/memos' do
  data = { "id" => SecureRandom.uuid , "content" => params[:content] }
  File.open("datas/#{data["id"]}.json", "w"){|file| JSON.dump(data, file)}
  redirect to '/memos'
end

get '/new' do
  erb :new
end

get '/memos/:id/edit' do
  data = File.open("datas/#{params[:id]}.json"){|file|JSON.load(file)}
  @id = params[:id]
  @content = data["content"]
  erb :edit
end

patch '/memos/:id' do
  data = { "id" => params[:id], "content" => params[:content] }
  File.open("datas/#{params[:id]}.json", "w"){|file| JSON.dump(data, file)}
  redirect to '/memos'
end
