require "application_system_test_case"

class SubitemsTest < ApplicationSystemTestCase
  setup do
    @subitem = subitems(:one)
  end

  test "visiting the index" do
    visit subitems_url
    assert_selector "h1", text: "Subitems"
  end

  test "creating a Subitem" do
    visit subitems_url
    click_on "New Subitem"

    fill_in "Account Type", with: @subitem.account_type
    fill_in "Description", with: @subitem.description
    fill_in "Level", with: @subitem.level
    fill_in "Name", with: @subitem.name
    click_on "Create Subitem"

    assert_text "Subitem was successfully created"
    click_on "Back"
  end

  test "updating a Subitem" do
    visit subitems_url
    click_on "Edit", match: :first

    fill_in "Account Type", with: @subitem.account_type
    fill_in "Description", with: @subitem.description
    fill_in "Level", with: @subitem.level
    fill_in "Name", with: @subitem.name
    click_on "Update Subitem"

    assert_text "Subitem was successfully updated"
    click_on "Back"
  end

  test "destroying a Subitem" do
    visit subitems_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Subitem was successfully destroyed"
  end
end
