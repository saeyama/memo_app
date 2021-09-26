require 'sinatra'
require 'sinatra/reloader'
require 'json'

get '/' do
  redirect to('/memos')
end

get '/memos' do
  erb :index
end

post '/memos' do
  @content = params[:content]
  erb :index
end

get '/new' do
  erb :new
end