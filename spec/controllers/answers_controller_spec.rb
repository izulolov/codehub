require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'POST #create' do
    let(:question) { create(:question) }

    context 'with valid data' do
      it 'creates new answer' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:answer) } }.to change(Answer, :count).by(1)
      end

      it 'associates answer with question' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer) }
        expect(Answer.last.question_id).to eq(question.id)
      end

      it 'increases answers count by 1' do
      end

      it 'redirects to question page' do
      end
    end

    context 'with invalid data' do
      it 'does not create answer' do
      end

      it 'renders/redirects with error' do
      end
    end

    context 'when question does not exist' do
      it 'returns 404 or raises error' do
      end
    end
  end
end
