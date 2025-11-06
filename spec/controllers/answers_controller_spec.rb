require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'POST #create' do
    let(:question) { create(:question) }

    context 'with valid data' do
      it 'creates new answer' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer) }

        expect(Answer.last).not_to be_nil
      end

      it 'increases answers count by 1' do
        expect {
          post :create, params: {
            question_id: question.id,
            answer: attributes_for(:answer)
          }
        }.to change(Answer, :count).by(1)
      end

      it 'associates answer with question' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer) }
        expect(Answer.last.question_id).to eq(question.id)
      end

      it 'redirects to question page' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer) }
        # expect(response).to redirect_to assigns(:question)
        expect(response).to redirect_to(question_path(question))
        expect(flash[:notice]).to eq('Answer was successfully created.')
      end
    end

    context 'with invalid data' do
      it 'does not create answer' do
        expect {
          post :create, params: {
            question_id: question.id,
            answer: attributes_for(:answer, body: nil)
          }
        }.not_to change(Answer, :count)
      end

      it 'redirects back to question with error' do
        post :create, params: {
          question_id: question.id,
          answer: attributes_for(:answer, body: nil)
        }

        expect(response).to redirect_to(question_path(question))
        expect(flash[:alert]).to eq('Failed to create answer.')
      end
    end
  end
end
