require 'sinatra'
require 'sinatra/activerecord'
require 'sqlite3'
require 'rake'
require './models'

set :database, {adapter: 'sqlite3', database: 'maskon.sqlite3'}
enable :sessions


get '/' do
    erb :home
end

get '/login' do
    erb :login
end

post '/login' do
    user = User.find_by(email: params[:email])
    given_password = params[:password]
    if user.password == given_password
        session[:user_id] = user.id
        session[:user_email] = user.email
        session[:user_name] = [user.first_name].join(' ')
        puts 'Welcome to the Velvet Room'
        redirect './profile'
    else
        puts 'Fool'
     redirect './login'
    end
end

get '/signup' do
    @user = User.new(params[:user])
    erb :signup
end

post '/signup' do
    @user = User.new(params[:user])
    if @user.valid?
        @user.save
        redirect '/login'
    else
        redirect './signup'
    end 
end

get '/profile' do
    erb :profile
    end

get '/logout' do
    session[:user_id] = nil
    session[:user_name] = nil
    redirect '/'
end

get '/post' do
    @posts = Post.all
    puts @posts
    erb :post
end
