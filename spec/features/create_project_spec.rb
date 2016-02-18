require 'rails_helper'

RSpec.feature "Project CRUD", :js do
  scenario "Admin creates, modifies, then destroys a project" do
    text = "The rumors of my death have been greatly exaggerated"

    visit new_session_path
    fill_in "password", with: ENV['SECRET']
    click_button "Sign in"

    expect(page).to have_content("Welcome to Shangri-La")

    click_link "Projects"
    click_link "New Project"
    fill_in "image_path", with: "portrait.jpg"
    fill_in "Project Text", with: text
    click_button "Create Project"

    expect(page).to have_content(text)

    click_link "Edit"
    fill_in "Project Text", with: "BATMAN!"
    click_button "Save Edits"

    expect(page).to have_content("Project updated")
    click_link "Edit"
    click_link "Delete Project"
    expect(page).not_to have_content("BATMAN!")
  end
end
