require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'pg'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end

  def db_connection(table_select)
    PG.connect(dbname: 'memo_db').exec(table_select)
  end
end

get '/' do
  redirect to '/memos'
end

get '/memos' do
  @datas = db_connection('SELECT * FROM Memo')
  erb :index
end

post '/memos' do
  db_connection("INSERT INTO Memo(content) VALUES ('#{params[:content]}')")
  redirect to '/memos'
end

get '/new' do
  erb :new
end

get '/memos/:id/edit' do
  @content = db_connection("SELECT * FROM Memo WHERE id='#{params[:id]}'").map { |row| row['content'].to_s }.join
  @id = params[:id]
  erb :edit
end

patch '/memos/:id' do
  db_connection("UPDATE Memo SET content = '#{params[:content]}' WHERE id='#{params[:id]}'")
  redirect to '/memos'
end

delete '/memos/:id' do
  db_connection("DELETE FROM Memo WHERE id='#{params[:id]}'")
  redirect to '/memos'
end
