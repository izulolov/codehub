require 'rails_helper'

feature 'User can create question', %q(
  In order to get answer from a comunity
  As an authenticated user
  I'd like to be able to ask the question
) do
  given(:user) { create(:user) }
  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit questions_path
      click_on 'Задать вопрос'
    end

    scenario 'asks a question' do
      fill_in 'Title', with: 'Test question with enough characters'
      fill_in 'Body', with: 'text text text text text text text text'
      click_on 'Создать вопрос'

      expect(page).to have_content 'Your question was succesfully created'
      expect(page).to have_content 'Test question with enough characters'
      expect(page).to have_content 'text text text text text text text text'
    end

    scenario 'asks a question with errors' do
      click_on 'Создать вопрос'

      expect(page).to have_content "Title can't be blank"
    end
  end

  scenario 'Unauthenticated user tries to ask a question' do
    visit questions_path
    click_on 'Задать вопрос'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
