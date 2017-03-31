require 'test_helper'

class ProductReviewsControllerTest < ActionController::TestCase
  setup do
    @product_review = product_reviews(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_reviews)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_review" do
    assert_difference('ProductReview.count') do
      post :create, product_review: { hash_message: @product_review.hash_message, message: @product_review.message, product_id: @product_review.product_id }
    end

    assert_redirected_to product_review_path(assigns(:product_review))
  end

  test "should show product_review" do
    get :show, id: @product_review
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_review
    assert_response :success
  end

  test "should update product_review" do
    patch :update, id: @product_review, product_review: { hash_message: @product_review.hash_message, message: @product_review.message, product_id: @product_review.product_id }
    assert_redirected_to product_review_path(assigns(:product_review))
  end

  test "should destroy product_review" do
    assert_difference('ProductReview.count', -1) do
      delete :destroy, id: @product_review
    end

    assert_redirected_to product_reviews_path
  end
end
