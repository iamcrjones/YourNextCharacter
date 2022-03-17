class ReviewsController < ApplicationController

    before_action :find_sheet, only: [:new, :create, :show, :destroy]
    before_action :find_review, only: [:destroy]
    def new
        puts @sheet.id
        @review = Review.new
    end

    def create
        @review = current_user.reviews.new
        @review.character_sheet_id = @sheet.id
        @review.rating = review_params[:rating]
        @review.comment = review_params[:comment]
        puts @review
        @review.save
        # @review.character_sheet_id = @sheet.id
        # @review.user_id = current_user.id
        redirect_to character_sheets_path
    end

    def destroy
        # @review = @sheet.reviews.all
        @review.destroy
        redirect_to character_sheets_path(@sheet)
        # if @review.user_id == current_user.id
        #     @review = @sheet.review.id
        #     redirect_to character_sheets_path(@sheet)
        # end
    end

    private

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
