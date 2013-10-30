enable :sessions

get '/sessions/login' do
  redirect to('/users/profile_page') if session[:logged_in]
  session[:logged_in] ||= false
  erb :login
  #login page
  #link to create account
end

post '/sessions/logged_in' do
  email = params[:email]
  password = params[:password]
  if User.exists?(email)
    @user = User.authenticate(email, password)
    if @user
      session[:logged_in] = true
      session[:first_name] = @user.first_name
      session[:email] = @user.email
      redirect to('/users/profile_page')
    else
      #say password is incorrect
      redirect to('/sessions/login')
    end
  else
    #say no user with that email in database
    redirect to('/users/create')
  end

end



post '/sessions/logout' do
  session[:logged_in] = false
  session[:first_name] = nil
  redirect to('/')
end