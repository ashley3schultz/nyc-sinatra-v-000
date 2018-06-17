class LandmarksController < ApplicationController

  get '/landmarks' do
    @list = Landmark.all
    erb :'landmarks/index'
  end

  get '/landmarks/new' do
    erb :'landmarks/new'
  end


###############################################
  post '/landmarks' do
    redirect "/figures/#{@figure.id}"
  end
###############################################


  get '/landmarks/:id/edit' do
    @landmark = Landmark.find("#{params[:id].to_i}")
    erb :'landmarks/edit'
  end


###############################################
  post '/landmarks/:id' do
    redirect "/landmarks/#{@landmark.id}"
  end
###############################################

  get '/landmarks/:id' do
    @titles = Title.all
    @figures = Figure.all
    @landmark = Landmark.find("#{params[:id].to_i}")
    erb :'landmarks/show'
  end

end
