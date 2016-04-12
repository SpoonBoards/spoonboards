require 'test_helper'

class CartItemsControllerTest < ActionController::TestCase
  setup do
    @cart_item = cart_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cart_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cart_item" do
    assert_difference('CartItem.count') do
      post :create, cart_item: { cart_id: @cart_item.cart_id, design_id: @cart_item.design_id, design_name: @cart_item.design_name, fabric_type: @cart_item.fabric_type, price: @cart_item.price, purchased: @cart_item.purchased, quantity: @cart_item.quantity, spoonflower_id: @cart_item.spoonflower_id, thumbnail_url: @cart_item.thumbnail_url }
    end

    assert_redirected_to cart_item_path(assigns(:cart_item))
  end

  test "should show cart_item" do
    get :show, id: @cart_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cart_item
    assert_response :success
  end

  test "should update cart_item" do
    patch :update, id: @cart_item, cart_item: { cart_id: @cart_item.cart_id, design_id: @cart_item.design_id, design_name: @cart_item.design_name, fabric_type: @cart_item.fabric_type, price: @cart_item.price, purchased: @cart_item.purchased, quantity: @cart_item.quantity, spoonflower_id: @cart_item.spoonflower_id, thumbnail_url: @cart_item.thumbnail_url }
    assert_redirected_to cart_item_path(assigns(:cart_item))
  end

  test "should destroy cart_item" do
    assert_difference('CartItem.count', -1) do
      delete :destroy, id: @cart_item
    end

    assert_redirected_to cart_items_path
  end
end
