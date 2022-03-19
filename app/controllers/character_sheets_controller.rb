class CharacterSheetsController < ApplicationController
    before_action :find_sheet , only: [:show, :edit, :update, :destroy]
    before_action :class_name , only: [:show]
    before_action :race_name, only: [:show]
    before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
    def index
        @sheets = CharacterSheet.all
    end

    def show
    end

    def new
        @sheet = CharacterSheet.new
    end

    # Creation of a chracter sheet which must pass through the parameters set.
    def create
        @sheet = CharacterSheet.create(sheet_params)
        begin
            redirect_to character_sheets_path, notice: "Character created successfully"
        rescue StandardError => e
            puts e.message
            redirect_to character_sheets_path, notice: "Creation unsuccessful"
        end
    end

    #The edit method first checks if the user is an Admin or if their user ID matches the user ID the character sheet is attached to. If this comes back false they will be redirected and given notice that they do not have permission.
    def edit
        if (current_user.admin?) or (current_user.id == @sheet.user_id) == true
            puts "Permissions accepted"
        else
            redirect_to character_sheets_path, alert: "You do not have required permissions to access this page"
        end
    end

    # Updates the attributes of the parameters passed through.
    def update
        @sheet.update(sheet_params)
        redirect_to character_sheets_path, notice: "#{@sheet.name} updated successfully"
    end

    # Destroys the target character sheet
    def destroy
        @sheet.destroy
        redirect_to character_sheets_path, notice: "#{@sheet.name} deleted successfully"
    end

    #These are the parameters that must be passed through in order for a character sheet to be created or updated in the database. It takes foreign keys from races, classes, and the user id so that any information edited about those foreign keys also updated the information on the character sheet.
    def sheet_params
        params.require(:character_sheet).permit(:name, :level, :description, :character_race_id, :character_class_id,  :user_id, :sheetupload)
    end

    # This is the method used to find which character sheet is currently being requested for an action. It finds the character sheet by using the find function with the parameter of ID being passed through.
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
    end
end
