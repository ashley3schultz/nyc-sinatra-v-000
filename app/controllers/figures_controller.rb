class FiguresController < ApplicationController
  get '/figures' do
    @list = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  post '/figures' do
    #@figure = Figure.create(params[:figure])
    @landmarks = []
    if !params[:landmark][:name].empty?
      @Landmarks << Landmarks.find_by(name: params[:landmark][:name]) || Landmark.create(params[:landmark])
    end
    #if params[:figure][:landmark_ids] != nil
    #  params[:figure][:landmark_ids].each do |landmark|
    #    id = landmark.split("landmark_").first.to_i
    #    @Landmarks << Landmark.find(id)
    #  end
    #end
    @titles = []
    if !params[:title][:name].empty?
      @titles << Title.find_by(name: params[:title][:name]) || Title.create(params[:title])
    end
    if params[:figure][:title_ids] != nil

      params[:figure][:title_ids].each do |title|
        id = title.split("title_").first.to_i
        binding.pry
        @titles << Title.find(id)
      end
    end
    #@figure.landmarks = @landmarks
    #@figure.titles = @titles
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
