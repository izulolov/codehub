require 'rails_helper'

feature 'User can sign up', %q(
  In order to ask questions and give answers
  As an unregistered user
  I'd like to be able to sign up
) do
  background { visit new_user_registration_path }

  scenario 'Unregistered user tries to sign up with valid data' do
    fill_in 'Email', with: 'newuser@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_button 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(page).to have_link 'Log out'
  end

  scenario 'Unregistered user tries to sign up with invalid email' do
    fill_in 'Email', with: 'invalid_email'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_button 'Sign up'

    expect(page).to have_content 'Email is invalid'
  end

  scenario 'Unregistered user tries to sign up with short password' do
    fill_in 'Email', with: 'newuser@test.com'
    fill_in 'Password', with: '123'
    fill_in 'Password confirmation', with: '123'
    click_button 'Sign up'

    expect(page).to have_content 'Password is too short'
  end

  scenario 'Unregistered user tries to sign up with mismatched passwords' do
    fill_in 'Email', with: 'newuser@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '87654321'
    click_button 'Sign up'

    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  scenario 'Unregistered user tries to sign up with existing email' do
    existing_user = create(:user, email: 'existing@test.com')

    fill_in 'Email', with: 'existing@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_button 'Sign up'

    expect(page).to have_content 'Email has already been taken'
  end
end
