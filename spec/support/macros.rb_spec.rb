def sign_in
  session[:admin] = true
end

def sign_in_admin
  visit new_session_path
  fill_in "password", with: ENV['SECRET']
  click_button "Sign in"
  expect(page).to have_content("Welcome to Shangri-La")
end
