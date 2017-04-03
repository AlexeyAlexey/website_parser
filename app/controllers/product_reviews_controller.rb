class ProductReviewsController < ApplicationController
  before_action :set_product, only: [:index, :show, :edit, :update, :destroy, :update_reviews]
  before_action :set_product_review, only: [:show, :edit, :update, :destroy]

  # GET /product_reviews
  # GET /product_reviews.json
  def index
    if params[:search_message]
      @search_message = params[:search_message]
      @product_reviews = @product.product_reviews.where("LOWER(product_reviews.message) LIKE LOWER(?)", "%#{@search_message}%")
    else
      @product_reviews = @product.product_reviews
    end
  end


  def update_reviews
        
    respond_to do |format|
      if @product.update({status: 3})
        WebParserUpdateReviewsWorker.perform_async(@product.id)

        format.html { redirect_to :back, notice: 'Product review was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_review }
      else
        format.html { redirect_to :back, notice: 'Product review was successfully updated.'}
        format.json { render json: {error: ""}, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_product
      @product = Product.find(params[:product_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_product_review
      @product_review = @product.product_reviews.where("id = ?", params[:id]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_review_params
      params.require(:product_review).permit(:product_id, :message)
    end

end
