class CharacterSheetsController < ApplicationController
    before_action :find_sheet , only: [:show]
    before_action :find_class , only: [:show]
    before_action :find_race , only: [:show]
    before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
    def index
        @sheets = CharacterSheet.all
    end

    def show
    end

    def new
        @sheet = CharacterSheet.new
    end

    def create
        @sheet = CharacterSheet.create(sheet_params)
        begin
        redirect_to character_sheets_path, notice: "Character created successfully"
        rescue StandardError => e
            puts e.message
            redirect_to character_sheets_path, notice: "Creation unsuccessful"
        end
    end

    def destroy
        charsheet = find_sheet
        name = charsheet.name
        charsheet.destroy
        redirect_to character_sheets_path, notice: "#{name} deleted successfully"
    end

    def sheet_params
        params.require(:character_sheet).permit(:name, :level, :description, :char_race_id, :char_class_id, :user_id, :sheetupload)
    end

    def isAdmin
        if !current_user.admin
            redirect_to character_races_path, alert: "You do not have required permissions to access this page"
        end
    end

    def find_sheet
        begin
            @sheet = CharacterSheet.find(params[:id])
        rescue StandardError => e
            puts e.message
            #flash[:error] = e.message
            redirect_to character_sheets_path, alert: "This character id #{params[:id]} does not exist in the database"
        end
    end

    #Determines if the class ID matches the class ID in the character sheet to display the name of that class
    def find_class
        @classes = CharacterClass.all
        @class = ""
        @classes.each do |c|
            c.id == @sheet.char_class_id?
            @class = c
        end
        @class_name = @class.charclass_name
    end

    #Determines if the race ID matches the race ID in the character sheet to display the name of that race
    def find_race
        @races = CharacterRace.all
        @race = ""
        @races.each do |r|
            r.id == @sheet.char_race_id?
            @race = r
        end
        @race_name = @race.race_name
    end
end
