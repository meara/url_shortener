
get '/users/create' do
  erb :create_user
end

post '/users/create' do
  @user = User.create(first_name: params[:first_name],
                                     last_name: params[:last_name],
                                     email: params[:email],
                                     password: params[:password])
  redirect to("/sessions/login")
end


get '/users/profile_page' do
  if session[:logged_in]
    @urls = Url.where(:user_id => current_user.id) || []
    erb :secret
  else
    redirect to('/sessions/login')
  end
end

post '/users/profile_page' do
    @new_url = Url.create(long_url: params[:long_url], user_id: current_user.id)
    if @new_url.valid?
      redirect to('/users/profile_page')
    else
      #return error message
      @urls = Url.where(:user_id => current_user.id) || []
      @message = @new_url.errors.messages[:long_url].first
      erb :secret
    end
end


# post '/urls' do
#   # create a new Url
#   @new_url = Url.create(long_url: params[:long_url])
#     if @new_url.valid?
#       redirect to('/')
#     else
#       #return error message
#       @urls = Url.all
#       @message = @new_url.errors.messages[:long_url].first
#       erb :index
#     end
# end