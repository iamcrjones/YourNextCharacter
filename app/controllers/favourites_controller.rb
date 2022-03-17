class FavouritesController < ApplicationController

    before_action :set_sheet, only:[:create, :destroy]

    def create
        if Favourite.create(favourited: @sheet, user: current_user)
        redirect_to @sheet, notice: 'Project has been favorited'
        else
        redirect_to @sheet, alert: 'Something went wrong...*sad panda*'
        end
    end

    def destroy
        Favourite.where(favourited_id: @sheet.id, user_id: current_user.id).first.destroy
        redirect_to @sheet, notice: 'Character is no longer in favorites'
    end

    def index
        @favourited = current_user.favourite_character_sheets.all
    end

    private

    def set_sheet
        @sheet = CharacterSheet.find(params[:character_sheet_id] || params[:id])
    end
end
