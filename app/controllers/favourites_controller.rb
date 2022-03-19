class FavouritesController < ApplicationController
    before_action :authenticate_user! , only: [:create, :destroy, :index]
    before_action :set_sheet, only:[:create, :destroy]

    #This creates a row in the favourites table, passing through the current user ID, and the character sheet ID
    def create
        if Favourite.create(favourited: @sheet, user: current_user)
        redirect_to @sheet, notice: "#{@sheet.name} has been favourited"
        else
        redirect_to @sheet, alert: 'Something went wrong...*sad panda*'
        end
    end

    #This destroys the row where the current character sheet ID and current user ID match in the database.
    def destroy
        Favourite.where(favourited_id: @sheet.id, user_id: current_user.id).first.destroy
        redirect_to @sheet, notice: "#{@sheet.name} is no longer in favourites"
    end

    #Lists all of the currently signed in user's favourite characters.
    def index
        @favourited = current_user.favourite_character_sheets.all
    end

    private

    def set_sheet
        @sheet = CharacterSheet.find(params[:character_sheet_id] || params[:id])
    end
end
