require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require 'sinatra/flash'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end
enable :sessions
require_relative "config/application"

set :views, (proc { File.join(root, "app/views") })
set :bind, '0.0.0.0'



get '/' do
  @posts = Post.all_desc_votes
  erb :posts
end

post '/new' do
  params[:url] = "http://#{params[:url]}" unless params[:url].start_with?('https', 'http')
  params[:user] = User.first
  post = Post.new(params)
  check = post.save
  check ? redirect('/') : redirect('/error')
end

get '/error' do
  erb :error
end

get '/upvote/:id' do
  post = Post.find(params[:id])
  post.votes += 1
  post.save!
  redirect("/##{params[:id]}")
end
