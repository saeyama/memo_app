require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'pg'
require './memo_db'

memo_db = Memodb.new

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

get '/' do
  redirect to '/memos'
end

get '/memos' do
  @datas = memo_db.table
  erb :index
end

post '/memos' do
  memo_db.row_create(params[:content])
  redirect to '/memos'
end

get '/new' do
  erb :new
end

get '/memos/:id/edit' do
  @id = params[:id]
  @content = memo_db.row_find_id(@id)[0]['content']
  erb :edit
rescue PG::InvalidTextRepresentation, IndexError
  redirect to 'not_found'
end

patch '/memos/:id' do
  memo_db.row_update(params[:content], params[:id])
  redirect to '/memos'
rescue PG::InvalidTextRepresentation, IndexError
  redirect to 'not_found'
end

delete '/memos/:id' do
  memo_db.row_delete(params[:id])
  redirect to '/memos'
rescue PG::InvalidTextRepresentation, IndexError
  redirect to 'not_found'
end

not_found do
  erb :not_found
end
