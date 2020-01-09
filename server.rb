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
    @user = User.find_by(email: params[:email])
    given_password = params[:password]
    if @user.password == given_password
        session[:user_id] = @user.id
        session[:user_name] = @user.first_name
        pp session[:user_id]
        redirect '/profile'
    else
        puts 'Fool'
     redirect '/login'
    end
end

get '/signup' do
    erb :signup
end

post '/signup' do
    @user = User.new(params[:user])
    if @user.valid?
        @user.save
        session[:user_id] = @user.id
        redirect '/profile'
    else
        redirect '/signup'
    end 
end

get '/profile' do
    @posts = Post.where(user_id: session[:user_id])
    puts @posts
    
    # session[:user_id] = @user.id
    erb :profile
end


get '/profile/:id' do
        @searchedID = params[:id]
        @user = User.find_by(id: params[:id])
        @posts = Post.where(user_id: params[:id])
        puts @user.id
        erb :profile
    end


post '/profile' do
    @post = Post.new(params[:post])
    if @post.valid?
        @post.user_id = session[:user_id]
           @post.save
        redirect '/profile'
        else
            redirect '/'
    end
end


get '/logout' do
    session[:user_id] = nil
    session[:user_name] = nil
    redirect '/'
end



get '/cancel' do
    erb :cancel
end

post '/cancel' do
    user = User.find_by(params['user_email'])
    user.destroy
    erb :signup
end



