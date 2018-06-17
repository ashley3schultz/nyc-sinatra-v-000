class LandmarksController < ApplicationController

  get '/landmarks' do
    @list = Landmark.all
    erb :'landmarks/index'
  end

  get '/landmarks/new' do
    erb :'landmarks/new'
  end

  post '/landmarks' do
    #@figures = Figure.find_by(name: params[:figure][:name])
    #if !params[:figure][:name].empty?
    #  @figures << Figure.create(name: params[:figure][:name])
    #end
    #if params[:landmark][:landmark_ids] != nil
    #  params[:landmark][:landmark_ids].each do |landmark|
    #    id = landmark.gsub("landmark_","").to_i
    #    @landmarks << Landmark.find(id)
    #  end
    #end
    #@titles = []
    #if !params[:title][:name].empty?
    #  @titles << Title.create(params[:title])
    #end
    #if params[:figure][:title_ids] != nil
    #  params[:figure][:title_ids].each do |title|
    #    id = title.gsub("title_","").to_i
    #    @titles << Title.find(id)
    #  end
    #end
    #@figure = Figure.find_by(name: params[:figure][:name]) || Figure.create(name: "#{params[:figure][:name]}")
    #@figure.landmarks = @landmarks
    #@figure.titles = @titles
    redirect "/figures/#{@figure.id}"
  end

  ##get '/landmarks/:id/edit' do
    @figure = Figure.find("#{params[:id].to_i}")
    erb :'figures/edit'
  end

  post '/figures/:id' do
    @figure = Figure.find("#{params[:id]}")
    @landmarks = []
    if !params[:landmark][:name].empty?
      @landmarks << Landmark.create(name: params[:landmark][:name])
    end
    if params[:figure][:landmark_ids] != nil
      params[:figure][:landmark_ids].each do |landmark|
        id = landmark.gsub("landmark_","").to_i
        @landmarks << Landmark.find(id)
      end
    end
    @titles = []
    if !params[:title][:name].empty?
      @titles << Title.create(params[:title])
    end
    if params[:figure][:title_ids] != nil
      params[:figure][:title_ids].each do |title|
        id = title.gsub("title_","").to_i
        @titles << Title.find(id)
      end
    end
    @figure.update(name: "#{params[:figure][:name]}")
    @figure.landmarks = @landmarks
    @figure.titles = @titles
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  get '/landmarks/:id' do
    @titles = Title.all
    @figures = Figure.all
    @landmark = Landmark.find("#{params[:id].to_i}")
    erb :'landmarks/show'
  end

end
