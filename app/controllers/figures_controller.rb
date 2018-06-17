class FiguresController < ApplicationController
  get '/figures' do
    @list = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  post '/figures' do
    if !params[:landmark][:name].empty?
      @landmark = Landmark.create(params[:landmark][:name])
    end
    binding.pry
    params["figure[landmark_ids]"].each do |l|
      landmark = Landmark.find(1)  
    end   
    
    if !params[:title][:name].empty?
      @title = Title.create(params[:title])
    end
    @figure = Figure.create(params[:figure])
    @figure.titles << @titles
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find("#{params[:id].to_i}")
    erb :'figures/edit'
  end

  post '/figures/:id' do
    @figure = Figure.find("#{params[:id]}")
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @titles = Title.all
    @landmarks = Landmark.all
    @figure = Figure.find("#{params[:id].to_i}")
    erb :'figures/show'
  end

end
