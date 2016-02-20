require 'rails_helper'

RSpec.feature "History CRUD", :js do
  scenario "Admin creates, modifies, then destroys a history" do
    text = Faker::Lorem.sentence(5)

    visit new_session_path
    fill_in "password", with: ENV['SECRET']
    click_button "Sign in"

    expect(page).to have_content("Welcome to Shangri-La")

    click_link "History"
    click_link "New History"
    fill_in "Subject", with: Faker::Lorem.word
    fill_in "History Text", with: text
    click_button "Create History"

    expect(page).to have_content(text)

    click_link "Edit"
    fill_in "History Text", with: "New Text"
    click_button "Save Edits"

    expect(page).to have_content("History Updated")
    expect(page).to have_content("New Text")
    click_link "Edit"
    click_link "Delete History"
    expect(page).to have_content("Another one bites the dust!")
    visit skills_path
    expect(page).not_to have_content("New Text")
  end
end
