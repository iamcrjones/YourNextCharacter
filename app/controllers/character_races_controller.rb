class CharacterRacesController < ApplicationController
    before_action :find_race, only:[:show]
    before_action :isAdmin , only: [:new, :create, :edit, :update, :destroy]
    def index
        @races = CharacterRace.all
    end

    def new
        @race = CharacterRace.new
    end
    # Method for creating a race. Only an Admin is able to add or edit any data relating to races as they are set already.
    def create
        character_race = CharacterRace.create(race_params)
        begin
        redirect_to character_races_path, notice: "#{character_race.race_name} created successfully"
        rescue StandardError => e
            puts e.message
            redirect_to character_races_path, notice: "#{character_race.race_name} creation unsuccessful"
        end
    end

    def destroy
        race = CharacterRace.find(params[:id])
        name = race.race_name
        race.destroy
        redirect_to character_races_path, notice: "#{name} deleted successfully"
    end

    def race_params
        params.require(:character_race).permit(:race_name, :description, :traits)
    end

    def isAdmin
        if !current_user.admin
            redirect_to character_races_path, alert: "You do not have required permissions to access this page"
        end
    end

    def find_race
        begin
            @race = CharacterRace.find(params[:id])
        rescue StandardError => e
            puts e.message
            #flash[:error] = e.message
            redirect_to character_races_path, alert: "This race id #{params[:id]} does not exist in the database"
        end
    end
end
