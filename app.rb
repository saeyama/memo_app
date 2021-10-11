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
  # @id = params[:id]
  @content = memo_db.row_find_id(params[:id])[0]
  #   erb :edit
  # rescue PG::InvalidTextRepresentation, IndexError
  #   redirect to 'not_found'

  # 試した方法１　登録なしの数字・文字ともにエラー
  # if @content.nil? || @content.empty?
  #   redirect to 'not_found'
  # else
  #   erb :edit
  # end

  #試した方法2　登録なしの数字・文字ともにエラー
  # if @content['content'].nil? || @content['content'].empty?
  #   redirect to 'not_found'
  # else
  #   erb :edit
  # end

  #試した方法3　登録なしの数字・文字ともにエラー
  # @content ? (erb :edit) : (redirect to 'not_found')

  #試した方法4 登録なしの数字だとnot_foundページに飛ぶが、文字はエラー
  # @id = params[:id]
  # @content = memo_db.row_find_id(params[:id]).find { |x| x['id'].include?(@id) }
  # if @content
  #   erb :edit
  # else
  #   erb :not_found
  # end

  # 試した方法に合わせて、edit.erbの内容も変更
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
