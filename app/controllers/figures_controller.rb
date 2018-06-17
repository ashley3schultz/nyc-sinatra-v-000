class FiguresController < ApplicationController
  get '/figures' do
    @list = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  post '/figures' do
  @title = params[:title]
  @title_ids = params[:figure][:title_ids]
  @landmark = params[:landmark]
  @landmark_ids = params[:figure][:landmark_ids]

  @figure = Figure.create(:name => params[:figure][:name])
  if !@title[:name].empty?
    t = Title.create(:name => @title[:name])
    @figure.titles << t
  end
  if @title_ids
    @title_ids.each do |id|
      t = Title.find(id)
      @figure.titles << t
    end
  end
  if !@landmark[:name].empty?
    l = Landmark.create(:name => @landmark[:name])
    @figure.landmarks << l
  end
  if @landmark_ids
    @landmark_ids.each do |id|
      l = Landmark.find(id)
      @figure.landmarks << l
    end
  end
  @figure.save
  redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @titles = Title.all
    @landmarks = Landmark.all
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
