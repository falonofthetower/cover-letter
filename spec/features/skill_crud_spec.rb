require 'rails_helper'

RSpec.feature "Project CRUD", :js do
  scenario "Admin creates, modifies, then destroys a skill" do
    text = Faker::Lorem.sentence(5)

    visit new_session_path
    fill_in "password", with: ENV['SECRET']
    click_button "Sign in"

    expect(page).to have_content("Welcome to Shangri-La")

    click_link "Skills"
    click_link "New Skill"
    fill_in "title", with: Faker::Lorem.word
    fill_in "Skill Text", with: text
    click_button "Create Skill"

    expect(page).to have_content(text)

    click_link "Edit"
    fill_in "Skill Text", with: "New Text"
    click_button "Save Edits"

    expect(page).to have_content("Skill Updated")
    expect(page).to have_content("New Text")
    click_link "Edit"
    click_link "Delete Skill"
    expect(page).to have_content("Another one bites the dust!")
    visit skills_path
    expect(page).not_to have_content("New Text")
  end
end
