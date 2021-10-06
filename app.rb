require 'sinatra'
require 'sinatra/reloader'
require 'json'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end

  def json_file_id
    File.basename(params[:id])
  end

  def datas_json_file
    "datas/#{json_file_id}.json"
  end
end

get '/' do
  redirect to '/memos'
end

get '/memos' do
  @datas = Dir.glob('datas/*').map { |data| JSON.parse(File.open(data).read) }
  erb :index
end

post '/memos' do
  data = { 'id' => SecureRandom.uuid, 'content' => params[:content] }
  File.open("datas/#{data['id']}.json", 'w') { |file| JSON.dump(data, file) }
  redirect to '/memos'
end

get '/new' do
  erb :new
end

get '/memos/:id/edit' do
  @id = json_file_id
  data = File.open(datas_json_file) { |file| JSON.parse(file.read, { symbolize_names: true }) }
  @content = data[:content]
  erb :edit
end

patch '/memos/:id' do
  data = { 'id' => params[:id], 'content' => params[:content] }
  File.open(datas_json_file, 'w') { |file| JSON.dump(data, file) }
  redirect to '/memos'
end

delete '/memos/:id' do
  File.delete(datas_json_file)
  redirect to '/memos'
end
