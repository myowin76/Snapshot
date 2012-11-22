require 'test_helper'

class BrandOwnersControllerTest < ActionController::TestCase
  setup do
    @brand_owner = brand_owners(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:brand_owners)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create brand_owner" do
    assert_difference('BrandOwner.count') do
      post :create, brand_owner: { description: @brand_owner.description, name: @brand_owner.name }
    end

    assert_redirected_to brand_owner_path(assigns(:brand_owner))
  end

  test "should show brand_owner" do
    get :show, id: @brand_owner
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @brand_owner
    assert_response :success
  end

  test "should update brand_owner" do
    put :update, id: @brand_owner, brand_owner: { description: @brand_owner.description, name: @brand_owner.name }
    assert_redirected_to brand_owner_path(assigns(:brand_owner))
  end

  test "should destroy brand_owner" do
    assert_difference('BrandOwner.count', -1) do
      delete :destroy, id: @brand_owner
    end

    assert_redirected_to brand_owners_path
  end
end
