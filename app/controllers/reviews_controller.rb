class ReviewsController < ApplicationController
    before_action :authenticate_user! , only: [:new, :create, :destroy]
    before_action :find_sheet, only: [:new, :create, :show, :destroy]
    before_action :find_review, only: [:destroy]
    def new
        puts @sheet.id
        @review = Review.new
    end

    # Creates a review for the currently displayed character sheet. Each review belongs to the user ID who created it.
    def create
        @review = current_user.reviews.new
        @review.character_sheet_id = @sheet.id
        @review.rating = review_params[:rating]
        @review.comment = review_params[:comment]
        puts @review
        @review.save
        redirect_to character_sheets_path
    end

    #Destroys the target review. Only an admin or the review creator can see the link to destroy.
    def destroy
        @review.destroy
        redirect_to character_sheets_path(@sheet)
    end

    private

    # The params to be passed through for creating a review.
    def review_params
        params.require(:review).permit(:rating, :comment)
    end

    def find_sheet
        @sheet = CharacterSheet.find(params[:character_sheet_id])
    end

    def find_review
        @review = Review.find(params[:id])
    end

end
