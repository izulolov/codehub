require 'rails_helper'

feature 'User can create answer', %q(
  In order to help community
  As a user
  I'd like to be able to answer the question
) do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit question_path(question)
    end

    scenario 'creates an answer with valid data' do
      fill_in 'Write your answer here...', with: 'This is my answer to your question with enough text'
      click_on 'Send a answer'

      expect(page).to have_content 'Answer was successfully created.'
      expect(page).to have_content 'This is my answer to your question with enough text'
      expect(page).to have_content 'Answers (1)'
    end

    scenario 'creates an answer with invalid data' do
      fill_in 'Write your answer here...', with: 'Short text'
      click_on 'Send a answer'

      expect(page).to have_content 'Errors:'
      expect(page).to have_content 'Body is too short'
    end

    scenario 'creates an answer with empty body' do
      click_on 'Send a answer'

      expect(page).to have_content 'Errors:'
      expect(page).to have_content "Body can't be blank"
    end

    scenario 'sees answer form on question page' do
      expect(page).to have_content 'Your answer'
      expect(page).to have_field 'Write your answer here...'
      expect(page).to have_button 'Send a answer'
    end
  end

  describe 'Unauthenticated user' do
    scenario 'does not see answer form' do
      visit question_path(question)

      expect(page).not_to have_content 'Your answer'
      expect(page).not_to have_field 'Write your answer here...'
      expect(page).not_to have_button 'Send a answer'
    end
  end
end
