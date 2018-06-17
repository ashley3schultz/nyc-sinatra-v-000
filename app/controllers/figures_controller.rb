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
      @landmarks = Landmark.create(params[:landmark])
    end
    if !params[:title][:name].empty?
      @titles = Title.create(params[:title])
    end
    @figure = Figure.create(params[:figure])
    @figure.titles << @titles if @titles != nil
    @figure.landmarks << @landmarks if @landmarks != nil
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find("#{params[:id].to_i}")
    erb :'figures/edit'
  end

  post '/figures/:id' do

    @landmarks = []
    params[:landmark].each do |l|
      landmark = Landmark.find_by(name: l.name) || Landmark.create(l)
      @landmarks << landmark
    end
    if !params[:landmark_name].empty?
      @landmarks << Landmark.create(name: params[:landmark_name], year: params[:landmark_year])
    end

    @titles = []
    params[:title].each do |t|
      title = Title.find_by(name: t.name) || Title.create(t)
      @titles << title
    end
    if !params[:title_name].empty?
      @titles << Title.create(name: params[:title_name])
    end

    @figure = Figure.update(name: params[:figure_name], titles: "#{@titles}", landmarks: "#{@landmarks}")

    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @titles = Title.all
    @landmarks = Landmark.all
    @figure = Figure.find("#{params[:id].to_i}")
    erb :'figures/show'
  end

end
