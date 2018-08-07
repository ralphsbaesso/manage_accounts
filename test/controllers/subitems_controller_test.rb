require 'test_helper'

class SubitemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subitem = subitems(:one)
  end

  test "should get index" do
    get subitems_url
    assert_response :success
  end

  test "should get new" do
    get new_subitem_url
    assert_response :success
  end

  test "should create subitem" do
    assert_difference('Subitem.count') do
      post subitems_url, params: { subitem: { account_type: @subitem.account_type, description: @subitem.description, level: @subitem.level, name: @subitem.name } }
    end

    assert_redirected_to subitem_url(Subitem.last)
  end

  test "should show subitem" do
    get subitem_url(@subitem)
    assert_response :success
  end

  test "should get edit" do
    get edit_subitem_url(@subitem)
    assert_response :success
  end

  test "should update subitem" do
    patch subitem_url(@subitem), params: { subitem: { account_type: @subitem.account_type, description: @subitem.description, level: @subitem.level, name: @subitem.name } }
    assert_redirected_to subitem_url(@subitem)
  end

  test "should destroy subitem" do
    assert_difference('Subitem.count', -1) do
      delete subitem_url(@subitem)
    end

    assert_redirected_to subitems_url
  end
end
