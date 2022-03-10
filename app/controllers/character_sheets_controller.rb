class CharacterSheetsController < ApplicationController
    before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
    before_action :isAdmin , only: [:new, :create, :edit, :update, :destroy]

    def index
        @sheets = CharacterSheet.all
    end

    def new
        @sheet = CharacterSheet.new
    end

    def create
        @sheet = CharacterSheet.create(sheet_params)
        puts "name = #{@sheet.name}"
        puts @sheet
        begin
        redirect_to character_sheets_path, notice: "#{@sheet.name} created successfully"
        rescue StandardError => e
            puts e.message
            redirect_to character_sheets_path, notice: "#{@sheet.name} creation unsuccessful"
        end
    end

    def sheet_params
        params.require(:character_sheet).permit(:name, :level, :description, :char_race_id, :char_class_id, :user_id)
    end

    def isAdmin
        if !current_user.admin
            redirect_to character_races_path, alert: "You do not have required permissions to access this page"
        end
    end
end
