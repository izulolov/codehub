require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'associations' do
    it { should belong_to(:question) }
    # it { should belong_to(:user) }
  end
  describe 'validations' do
    context 'body' do
      it { should validate_presence_of(:body) }
      it { should validate_length_of(:body).is_at_least(32) }
      it { should validate_length_of(:body).is_at_most(2048) }
    end
  end

  describe 'edge cases' do
    context 'whitespace handling' do
      it 'is invalid when body is only spaces' do
        answer = build(:answer, body: '                                ')
        expect(answer).to_not be_valid
        expect(answer.errors[:body]).to include("can't be blank")
      end

      it 'strips leading and trailing spaces' do
        answer = create(:answer, body: '  Valid body content here that is long enough to pass validation  ')
        expect(answer.body).to eq('Valid body content here that is long enough to pass validation')
      end
    end

    context 'length boundaries' do
      it 'is valid at minimum length (32 chars)' do
        answer = build(:answer, body: 'a' * 32)
        expect(answer).to be_valid
      end

      it 'is invalid below minimum (31 chars)' do
        answer = build(:answer, body: 'a' * 31)
        expect(answer).to_not be_valid
        expect(answer.errors[:body]).to include('is too short (minimum is 32 characters)')
      end

      it 'is valid at maximum length (2048 chars)' do
        answer = build(:answer, body: 'a' * 2048)
        expect(answer).to be_valid
      end

      it 'is invalid above maximum (2049 chars)' do
        answer = build(:answer, body: 'a' * 2049)
        expect(answer).to_not be_valid
        expect(answer.errors[:body]).to include('is too long (maximum is 2048 characters)')
      end
    end
  end

  describe 'database columns' do
    it { should have_db_column(:body).of_type(:text).with_options(null: false) }
    # Проверим когда добавлю user_id и question_id
    # it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:question_id).of_type(:integer) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'indexes on db' do
    it { should have_db_index(:body) }
    it { should have_db_index(:created_at) }
  end
end
