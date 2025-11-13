require 'rails_helper'

feature 'User can view questions list', %q(
  In order to find interesting questions
  As a user
  I'd like to be able to view all questions
) do
  given!(:questions) { create_list(:question, 3) }

  scenario 'User views all questions' do
    visit questions_path

    expect(page).to have_content 'All questions on the CodeHub website'
    expect(page).to have_link "Create a question", href: new_question_path

    questions.each do |question|
      expect(page).to have_content question.title
      expect(page).to have_link question.title, href: question_path(question)
    end
  end

  scenario 'User sees "Ask question" link' do
    visit questions_path

    expect(page).to have_link "Create a question", href: new_question_path
  end

  scenario 'User can click on question title to view details' do
    visit questions_path

    click_on questions.first.title
    expect(page).to have_current_path question_path(questions.first)
    expect(page).to have_content questions.first.title
    expect(page).to have_content questions.first.body
  end
end
