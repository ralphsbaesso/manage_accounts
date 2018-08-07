require 'test_helper'

class AccountantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @accountant = accountants(:one)
  end

  test "should get index" do
    get accountants_url
    assert_response :success
  end

  test "should get new" do
    get new_accountant_url
    assert_response :success
  end

  test "should create accountant" do
    assert_difference('Accountant.count') do
      post accountants_url, params: { accountant: {  } }
    end

    assert_redirected_to accountant_url(Accountant.last)
  end

  test "should show accountant" do
    get accountant_url(@accountant)
    assert_response :success
  end

  test "should get edit" do
    get edit_accountant_url(@accountant)
    assert_response :success
  end

  test "should update accountant" do
    patch accountant_url(@accountant), params: { accountant: {  } }
    assert_redirected_to accountant_url(@accountant)
  end

  test "should destroy accountant" do
    assert_difference('Accountant.count', -1) do
      delete accountant_url(@accountant)
    end

    assert_redirected_to accountants_url
  end
end
