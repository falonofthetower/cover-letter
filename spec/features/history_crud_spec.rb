require 'rails_helper'

RSpec.feature "History CRUD", :js do
  scenario "Admin creates, modifies, then destroys a history" do
    sign_in_admin


    history = build_history
    create_history(history)
    expect(page).to have_content(history.subject)
    expect(page).to have_content(history.text)

    edit_history_text("BATMAN!")
    expect(page).to have_content("History Updated")
    expect(page).to have_content("BATMAN!")

    delete_history
    expect(page).to have_content("Another one bites the dust!")
    expect(page).not_to have_content("BATMAN!")

    history_1 = build_history(1)
    history_2 = build_history(2)
    history_3 = build_history(3)

    create_history(history_2)
    create_history(history_3)
    create_history(history_1)

    expect(history_1.text).to appear_before(history_2.text)
    expect(history_2.text).to appear_before(history_3.text)
  end
end

def edit_history_text(new_text)
  click_link "Edit"
  fill_in "History Text", with: new_text
  click_button "Update History"
end

def create_history(history)
  click_link "History"
  expect(page).to have_link('New History')
  find(:xpath, '//a[@id="new_history"]').trigger('click')
  expect(page).to have_content('Add new History')
  fill_in "Subject", with: history.subject
  fill_in "History Text", with: history.text
  fill_in "Weight", with: history.weight
  click_button "Create History"
end

def delete_history
  click_link "Edit"
  click_link "Delete History"
end

def build_history(weight = "")
  Fabricate.build(:history, weight: weight)
end
