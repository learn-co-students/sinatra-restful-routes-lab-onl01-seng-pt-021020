class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to '/recipes'
  end

  get '/recipes' do
    @recipes = Recipe.all

    erb :index
  end

  post '/recipes' do
    @recipe = Recipe.new(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])

    if @recipe.save
      redirect to "/recipes/#{@recipe.id}"
    else
      redirect to '/recipes/new'
    end
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])

    erb :show
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])

    erb :show
  end

  delete '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.delete

    redirect to '/'
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])

    erb :edit
  end

end
