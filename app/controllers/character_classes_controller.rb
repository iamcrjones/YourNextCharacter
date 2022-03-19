class CharacterClassesController < ApplicationController
    before_action :find_charclass, only:[:show, :edit, :update, :destroy]
    before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
    before_action :isAdmin , only: [:new, :create, :edit, :update, :destroy]

    def index
        @charclasses = CharacterClass.all
        # Orders all of the character classes by name in ascending order.
        @class_order = @charclasses.order('charclass_name ASC')
    end

    def show
    end

    def new
        @charclass = CharacterClass.new
    end

    # Method for creating a class. Only an Admin is able to perform any CRUD operations to races or classes as these should not be editable by regular users.
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
    end

    # Updates the target class found by find_charclass passing through the params.
    def update
        @charclass.update(charclass_params)
        redirect_to character_classes_path, notice: "#{@charclass.charclass_name} updated successfully"
    end

    #This is how a class is destroyed from the database. Finds the ID of the race chosen and then performs destroy statement
    def destroy
        @charclass.destroy
        redirect_to character_classes_path, notice: "#{@charclass.charclass_name} deleted successfully"
    end

    #Parameters that must be passed through in order for a class to be created or updated
    def charclass_params
        params.require(:character_class).permit(:charclass_name, :description, :bis_stats)
    end

    # This is the method used to find which class is currently being requested for an action. It finds the class by using the find function with the parameter of ID being passed through.
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
