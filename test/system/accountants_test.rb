require "application_system_test_case"

class AccountantsTest < ApplicationSystemTestCase
  setup do
    @accountant = accountants(:one)
  end

  test "visiting the index" do
    visit accountants_url
    assert_selector "h1", text: "Accountants"
  end

  test "creating a Accountant" do
    visit accountants_url
    click_on "New Accountant"

    click_on "Create Accountant"

    assert_text "Accountant was successfully created"
    click_on "Back"
  end

  test "updating a Accountant" do
    visit accountants_url
    click_on "Edit", match: :first

    click_on "Update Accountant"

    assert_text "Accountant was successfully updated"
    click_on "Back"
  end

  test "destroying a Accountant" do
    visit accountants_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Accountant was successfully destroyed"
  end
end
