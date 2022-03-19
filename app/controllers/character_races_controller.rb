class CharacterRacesController < ApplicationController
    before_action :find_race, only:[:show, :edit, :update, :destroy]
    before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
    before_action :isAdmin , only: [:new, :create, :edit, :update, :destroy]

    def index
        @races = CharacterRace.all
        # This orders all of the races by name in ascending order for the index.
        @race_order = @races.order('race_name ASC')
    end

    def new
        @race = CharacterRace.new
    end

    # Method for creating a race. Only an Admin is able to perform any CRUD operations to races as regular users do not have authorization for this.
    def create
        character_race = CharacterRace.create(race_params)
        begin
        redirect_to character_races_path, notice: "#{character_race.race_name} created successfully"
        rescue StandardError => e
            puts e.message
            redirect_to character_races_path, notice: "#{character_race.race_name} creation unsuccessful"
        end
    end

    def edit
    end

    # Updates the Race with the required attributes passed through by params.
    def update
        @race.update(race_params)
        redirect_to character_races_path, notice: "#{@race.race_name} updated successfully"
    end

    #This is how a race is destroyed from the database. Finds the ID of the race chosen and then performs destroy statement
    def destroy
        @race.destroy
        redirect_to character_races_path, notice: "#{@race.race_name} deleted successfully"
    end

    #The parameters that must be passed through in order for a race to be created or updated.
    def race_params
        params.require(:character_race).permit(:race_name, :description, :traits)
    end

    # This is the method used to find which race is currently being requested for an action. It finds the race by using the find function with the parameter of ID being passed through.
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
