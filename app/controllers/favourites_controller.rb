class FavouritesController < ApplicationController

    def new
        @favourite = Favourite.new
    end

    def index
    end

    def create
        @favourite = Favourite.create(fave_params)
        redirect_to favourites_path
    end

    def fave_params
        params.require(:favourite).permit(:user_id, :character_sheet_id)
    end

    def find_sheet
        @sheet = CharacterSheet.find(params[:id])
    end
end
