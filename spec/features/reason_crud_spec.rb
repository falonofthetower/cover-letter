require 'rails_helper'

RSpec.feature "Reason CRUD", :js do
  scenario "Admin creates, modifies, then destroys a reason" do
    text = Faker::Lorem.sentence(5)

    visit new_session_path
    fill_in "password", with: ENV['SECRET']
    click_button "Sign in"

    expect(page).to have_content("Welcome to Shangri-La")

    click_link "Why"
    click_link "New Reason"
    fill_in "Header", with: Faker::Lorem.sentence
    fill_in "Reason Text", with: text
    click_button "Create Reason"

    expect(page).to have_content(text)

    click_link "Edit"
    fill_in "Reason Text", with: "New Text"
    click_button "Save Edits"

    expect(page).to have_content("Reason updated")
    expect(page).to have_content("New Text")
    click_link "Edit"
    click_link "Delete Reason"
    expect(page).to have_content("Another one bites the dust!")
    visit reasons_path
    expect(page).not_to have_content("New Text")
  end
end
