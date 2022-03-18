class CharacterClassesController < ApplicationController
    before_action :find_charclass, only:[:show]
    before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
    before_action :isAdmin , only: [:new, :create, :edit, :update, :destroy]

    def index
        @charclasses = CharacterClass.all
        @class_order = @charclasses.order('charclass_name ASC')
    end

    def show
    end

    def new
        @charclass = CharacterClass.new
    end

    # Method for creating a race. Only an Admin is able to add or edit any data relating to races as they are set already.
    def create
        character_class = CharacterClass.create(charclass_params)
        begin
        redirect_to character_classes_path, notice: "#{character_class.charclass_name} created successfully"
        rescue StandardError => e
            puts e.message
            redirect_to character_classes_path, notice: "#{character_class.charclass_name} creation unsuccessful"
        end
    end

    def edit
        find_charclass
    end

    def update
        @charclass = find_charclass
        @charclass.update(charclass_params)
        redirect_to character_classes_path, notice: "#{@charclass.charclass_name} updated successfully"
    end

    #This is how a race is destroyed from the database. Finds the ID of the race chosen and then performs destroy statement
    def destroy
        charclass = find_charclass
        charclass.destroy
        redirect_to character_classes_path, notice: "Class deleted successfully"
    end

    def charclass_params
        params.require(:character_class).permit(:charclass_name, :description, :bis_stats)
    end

    def isAdmin
        if !current_user.admin
            redirect_to character_classes_path, alert: "You do not have required permissions to access this page"
        end
    end

    def find_charclass
        begin
            @charclass = CharacterClass.find(params[:id])
        rescue StandardError => e
            puts e.message
            #flash[:error] = e.message
            redirect_to character_classes_path, alert: "This class id: #{params[:id]} does not exist in the database"
        end
    end
end
