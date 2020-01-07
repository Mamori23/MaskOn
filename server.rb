require 'sinatra'
require 'sinatra/activerecord'
require 'rake'
require 'pg'
require './models'


set :database, {adapter: 'postgresql', database: 'maskon'}
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
    # post = Post.new(content: params[:content], email: @user.email, user_id: session[user_id] )
    # if @post.vaild?
    #     @post.save  
    #    redirect '/dashboard'
    # @posts = Post.all
    # puts @posts
    erb :post
end
end


get '/dashboard' do
    erb :dashboard
end 

post '/dashboard' do
    post = Post.new(content: params[:content], email: @user.email, user_id: session[user_id] )
    if @post.vaild?
        @post.save  
       redirect '/dashboard'
    end
end