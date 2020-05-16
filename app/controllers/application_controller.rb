require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to '/recipes'
  end

  get "/recipes" do
    @recipes = Recipe.all
    erb :index
  end
  
  get "/recipes/new" do
    erb :new
  end

  post "/recipes" do
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect to "/recipes/#{@recipe.id}"
  end
  
  get "/recipes/:id" do
    @recipe = Recipe.find(params[:id])
    erb :show
  end
  
  get "/recipes/:id/edit" do
    @recipe_edit = Recipe.find(params[:id])
    erb :edit
  end

  patch "/recipes/:id" do
    @recipe_edit = Recipe.find(params[:id])
    @recipe_edit.name = params[:name]
    @recipe_edit.ingredients = params[:ingredients]
    @recipe_edit.cook_time = params[:cook_time]
    @recipe_edit.save
    redirect to "/recipes/#{@recipe_edit.id}"
  end

  delete "/recipes/:id" do
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect to "/recipes"
  end

end
