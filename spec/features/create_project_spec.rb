require 'rails_helper'

RSpec.feature "Project CRUD", :js do
  scenario "Admin creates, modifies, then destroys a project" do
    sign_in_admin

    project = build_project
    create_project(project)
    expect(page).to have_content(project.title)
    expect(page).to have_content(project.text)

    edit_project_text("BATMAN!")

    expect(page).to have_content("BATMAN!")
    expect(page).to have_content("Project updated")

    delete_project
    expect(page).not_to have_content("BATMAN!")

    project_1 = build_project(1)
    project_2 = build_project(2)
    project_3 = build_project(3)

    create_project(project_2)
    create_project(project_3)
    create_project(project_1)

    expect(project_1.text).to appear_before(project_2.text)
    expect(project_2.text).to appear_before(project_3.text)
  end
end

def edit_project_text(new_text)
  click_link "Edit"
  fill_in "Project Text", with: new_text
  click_button "Update Project"
end

def create_project(project)
  click_link "Projects"
  expect(page).to have_link('New Project')
  find(:xpath, '//a[@id="new_project"]').trigger('click')
  expect(page).to have_content('Add new Project')
  fill_in "Title", with: project.title
  fill_in "Project Text", with: project.text
  fill_in "Weight", with: project.weight
  click_button "Create Project"
end

def delete_project
  click_link "Edit"
  click_link "Delete Project"
end

def build_project(weight = "")
  Fabricate.build(:project, weight: weight)
end
