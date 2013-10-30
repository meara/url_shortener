# get '/' do
#   # Look in app/views/index.erb
#   erb :index
# end


get '/' do
  # let user create new short URL, display a list of shortened URLs
  @urls = Url.all
  erb :index
end

post '/urls' do
  # create a new Url
  @new_url = Url.create(long_url: params[:long_url])
    if @new_url.valid?
      redirect to('/')
    else
      #return error message
      @urls = Url.all
      @message = @new_url.errors.messages[:long_url].first
      erb :index
    end
end

# e.g., /q6bda
get '/:short_url' do
  # redirect to appropriate "long" URL
  @url = Url.find_by_short_url('/' + params[:short_url])
  #increment the counter
  Url.increment_counter(:click_count, @url.id)
  redirect to(@url.long_url)
end

