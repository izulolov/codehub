require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }
  let(:valid_attributes) { attributes_for(:answer) }
  let(:invalid_attributes) { attributes_for(:answer, body: nil) }

  describe 'POST #create' do
    context 'with valid data' do
      subject(:create_answer) do
        post :create, params: { question_id: question.id, answer: valid_attributes }
      end

      it 'creates a new answer associated with the question' do
        expect { create_answer }.to change(question.answers, :count).by(1)
      end

      it 'redirects to question page with success notice' do
        create_answer

        expect(response).to redirect_to(question_path(question))
        expect(flash[:notice]).to eq('Answer was successfully created.')
      end
    end

    context 'with invalid data' do
      subject(:create_invalid_answer) do
        post :create, params: { question_id: question.id, answer: invalid_attributes }
      end

      it 'does not create an answer' do
        expect { create_invalid_answer }.not_to change(Answer, :count)
      end

      it 'renders question show template with error message' do
        create_invalid_answer

        expect(response).to render_template('questions/show')
        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash[:alert]).to eq('Failed to create answer.')
      end
    end
  end

  describe 'PATCH #update' do
    let(:new_body) { "This is new body for testing update test!" }

    context 'with valid data' do
      subject(:update_answer) do
        patch :update, params: { question_id: question.id, id: answer.id, answer: { body: new_body } }
      end

      it 'updates the answer' do
        expect { update_answer }.to change { answer.reload.body }.from(answer.body).to(new_body)
      end

      it 'redirects to question page with success notice' do
        update_answer
        expect(response).to redirect_to(question_path(question))
        expect(flash[:notice]).to eq('Answer was successfully updated.')
      end
    end

    context 'with invalid data' do
      subject(:update_invalid_answer) do
        patch :update, params: { question_id: question.id, id: answer.id, answer: invalid_attributes }
      end

      it 'does not update the answer' do
        expect { update_invalid_answer }.not_to change { answer.reload.body }
      end

      it 'renders question show template with error message' do
        update_invalid_answer

        expect(response).to render_template('questions/show')
        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash[:alert]).to eq('Failed to update answer.')
      end
    end
  end
end
