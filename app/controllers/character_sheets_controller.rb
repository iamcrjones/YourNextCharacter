class CharacterSheetsController < ApplicationController
    before_action :find_sheet , only: [:show]
    before_action :class_name , only: [:show]
    before_action :race_name, only: [:show]
    before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
    def index
        @sheets = CharacterSheet.all
    end

    def show
        #race_name
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

    def edit
        @sheet = find_sheet
    end

    def update
        @sheet = find_sheet
        @sheet.update(sheet_params)
        redirect_to character_sheets_path, notice: "#{@sheet.name} updated successfully"
    end

    def destroy
        charsheet = find_sheet
        name = charsheet.name
        charsheet.destroy
        redirect_to character_sheets_path, notice: "#{name} deleted successfully"
    end

    def sheet_params
        params.require(:character_sheet).permit(:name, :level, :description, :character_race_id, :character_class_id,  :user_id, :sheetupload)#, :char_race_id, :char_class_id, :user_id, :sheetupload)
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

    # #Determines if the class ID matches the class ID in the character sheet to display the name of that class
    def class_name
        @sheetfind = find_sheet.character_class_id
        @classes = CharacterClass.all
        @classes.each do |c|
          if c.id == @sheetfind
               @sheetclass = c.charclass_name
          end
       end
       # sheet_race_id = find_sheet.char_race_id
       # @race = ''
   end

    # #Determines if the race ID matches the race ID in the character sheet to display the name of that race
     def race_name
         @sheetfind = find_sheet.character_race_id
         @races = CharacterRace.all
         @races.each do |r|
           if r.id == @sheetfind
                @sheetrace = r.race_name
           end
        end
        # sheet_race_id = find_sheet.char_race_id
        # @race = ''
    end
end
