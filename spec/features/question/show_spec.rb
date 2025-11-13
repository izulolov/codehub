require 'rails_helper'

feature 'User can view question and its answers', %q(
  In order to find solution
  As a user
  I'd like to be able to view question with all answers
) do
  given(:question) { create(:question) }
  given!(:answers) { create_list(:answer, 3, question: question) }

  scenario 'User views question details' do
    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body
    expect(page).to have_content "Question ##{question.id}"
  end

  scenario 'User views all answers for the question' do
    visit question_path(question)

    expect(page).to have_content "Answers (#{answers.count})"

    answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end

  scenario 'User sees message when no answers exist' do
    question_without_answers = create(:question)

    visit question_path(question_without_answers)

    expect(page).to have_content 'Answers (0)'
    expect(page).to have_content 'There are no answers yet. Be the first!'
  end

  scenario 'User can navigate back to questions list' do
    visit question_path(question)

    click_on 'Back to list'

    expect(page).to have_current_path(questions_path)
  end
end
