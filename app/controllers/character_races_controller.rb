class CharacterRacesController < ApplicationController
    def index
    end

    def create
        #Movie.create(title: movie_params[:title], genre: movie_params[:genre], year: movie_params[:year], length: movie_params[:length])
        movie = Movie.create(movie_params)
        begin
        redirect_to movies_path, notice: "#{movie.title} created successfully"
        rescue StandardError => e
            puts e.message
            redirect_to movies_path, notice: "#{movie.title} creation unsuccessful"
        end
    end

    def race_params
        params.require(:character_race).permit(:race_name, :description, :traits)
    end
end
