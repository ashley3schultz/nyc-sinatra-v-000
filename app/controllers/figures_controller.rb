class FiguresController < ApplicationController
  get '/figures' do
    @list = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  post '/figures' do
    @landmarks = []
    if !params[:landmark][:name].empty? && !params[:landmark][:year].empty?
      @landmarks << Landmark.create(params[:landmark])
    end
    binding.pry
    if params[:figure][:landmark_ids] != nil
      params[:figure][:landmark_ids].each do |landmark|
        id = landmark.gsub("landmark_","").to_i
        @landmarks << Landmark.find(id)
      end
    end
    @titles = []
    #if !params[:title][:name].empty?
    #  @titles << Title.find_by(name: params[:title][:name]) || Title.create(params[:title])
    #end
    if params[:figure][:title_ids] != nil
      params[:figure][:title_ids].each do |title|
        id = title.gsub("title_","").to_i
        @titles << Title.find(id)
      end
    end
    @figure = Figure.find_by(name: params[:figure][:name]) || Figure.create(name: "#{params[:figure][:name]}")
    @figure.landmarks = @landmarks
    @figure.titles = @titles
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
