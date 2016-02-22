require 'rails_helper'

RSpec.feature "Reason CRUD", :js do
  scenario "Admin creates, modifies, then destroys a reason" do
    sign_in_admin

    reason = build_reason
    create_reason(reason)
    expect(page).to have_content(reason.header)
    expect(page).to have_content(reason.text)

    edit_reason_text("BATMAN!")
    expect(page).to have_content("Reason updated")
    expect(page).to have_content("BATMAN!")

    delete_reason
    expect(page).to have_content("Another one bites the dust!")
    expect(page).not_to have_content("BATMAN!")

    reason_1 = build_reason(1)
    reason_2 = build_reason(2)
    reason_3 = build_reason(3)

    create_reason(reason_2)
    create_reason(reason_3)
    create_reason(reason_1)

    expect(reason_1.text).to appear_before(reason_2.text)
    expect(reason_2.text).to appear_before(reason_3.text)
  end
end

def edit_reason_text(new_text)
  click_link "Edit"
  fill_in "Reason Text", with: new_text
  click_button "Update Reason"
end

def create_reason(reason)
  click_link "Why"
  click_link "New Reason"
  fill_in "Header", with: reason.header
  fill_in "Reason Text", with: reason.text
  fill_in "Weight", with: reason.weight
  click_button "Create Reason"
end

def delete_reason
  click_link "Edit"
  click_link "Delete Reason"
end

def build_reason(weight = "")
  Fabricate.build(:reason, weight: weight)
end
