require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'pg'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end

  def db_connect
    PG.connect(dbname: 'memo_db')
  end

  def find_id_db_connection(table_select, *row)
    db_connect.exec(table_select, row)
  end
end

get '/' do
  redirect to '/memos'
end

get '/memos' do
  @datas = db_connect.exec('SELECT * FROM Memo')
  erb :index
end

post '/memos' do
  content = params[:content]
  find_id_db_connection('INSERT INTO Memo(content) VALUES ($1) RETURNING id', content)
  redirect to '/memos'
end

get '/new' do
  erb :new
end

get '/memos/:id/edit' do
  id = params[:id]
  @id = params[:id]
  @content = find_id_db_connection('SELECT * FROM Memo WHERE id=$1', id).map { |row| row['content'].to_s }.join
  erb :edit
end

patch '/memos/:id' do
  content = params[:content]
  id = params[:id]
  find_id_db_connection('UPDATE Memo SET content=$1 WHERE id=$2;', content, id)
  redirect to '/memos'
end

delete '/memos/:id' do
  id = params[:id]
  find_id_db_connection('DELETE FROM Memo WHERE id=$1;', id)
  redirect to '/memos'
end
