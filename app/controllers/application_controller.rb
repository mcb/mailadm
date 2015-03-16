module Mailadm
  class ApplicationController < Mailadm::App
    get '/users' do
      @users = Mailadm::User.all
      erb 'users/index'.to_sym
    end

    get '/users/:id/edit' do
      @user = Mailadm::User.where(:id => params[:id]).first
      erb 'users/edit'.to_sym
    end

    put '/users/:id' do
      @user = Mailadm::User.where(:id => params[:id]).first
      @user.set(
        :username => @user.username,
        :domain => @user.domain,
        :password => params[:user][:password])
      @user.save
      redirect '/users'
    end
  end
end
