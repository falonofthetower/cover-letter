require 'rails_helper'

RSpec.feature "Skill CRUD", :js do
  scenario "Admin creates, modifies, then destroys a skill" do
    sign_in_admin

    skill = build_skill
    create_skill(skill)
    expect(page).to have_content(skill.title)
    expect(page).to have_content(skill.text)

    edit_skill_text("BATMAN!")

    expect(page).to have_content("BATMAN!")
    expect(page).to have_content("Skill updated")

    delete_skill
    expect(page).not_to have_content("BATMAN!")
    skill_1 = build_skill(1)
    skill_2 = build_skill(2)
    skill_3 = build_skill(3)

    create_skill(skill_2)
    create_skill(skill_3)
    create_skill(skill_1)

    expect(skill_1.title).to appear_before(skill_2.title)
    expect(skill_2.title).to appear_before(skill_3.title)
  end
end

def edit_skill_text(new_text)
  click_link "Edit"
  fill_in "Skill Text", with: new_text
  click_button "Update Skill"
end

def create_skill(skill)
  expect(page).to have_content("Skills")
  click_link "Skills"
  expect(page).to have_link('New Skill')
  find(:xpath, '//a[@id="new_skill"]').trigger('click')
  expect(page).to have_content('Add new Skill')
  fill_in "Title", with: skill.title
  fill_in "Skill Text", with: skill.text
  fill_in "Weight", with: skill.weight
  click_button "Create Skill"
end

def delete_skill
  click_link "Edit"
  click_link "Delete Skill"
end

def build_skill(weight = "")
  Fabricate.build(:skill, weight: weight)
end
