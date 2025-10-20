require 'rails_helper'

RSpec.describe Question, type: :model do
  subject { build(:question) }

  describe 'associations' do
    # it { should belong_to(:user) }
    it { should have_many(:answers).dependent(:destroy) }
  end

  describe 'validations' do
    context 'title' do
      it { should validate_presence_of(:title) }
      it { should validate_length_of(:title).is_at_least(16) }
      it { should validate_length_of(:title).is_at_most(256) }
      it { should validate_uniqueness_of(:title) }
    end

    context 'body' do
      it { should validate_presence_of(:body) }
      it { should validate_length_of(:body).is_at_least(32) }
      it { should validate_length_of(:body).is_at_most(1024) }
    end
  end

  describe 'edge cases' do
    context 'whitespace handling' do
      context 'title' do
        it 'is invalid when title is only spaces' do
          question = build(:question, title: '                ')
          expect(question).to_not be_valid
          expect(question.errors[:title]).to include("can't be blank")
        end

        it 'strips leading and trailing spaces' do
          question = create(:question, title: '  Valid Title Here  ')
          expect(question.title).to eq('Valid Title Here')
        end
      end

      context 'body' do
        it 'is invalid when body is only spaces' do
          question = build(:question, body: '                ')
          expect(question).to_not be_valid
          expect(question.errors[:body]).to include("can't be blank")
        end

        it 'strips leading and trailing spaces' do
          question = create(:question, body: '  Valid body content here that is long enough to pass validation  ')
          expect(question.body).to eq('Valid body content here that is long enough to pass validation')
        end
      end
    end

    context 'length boundaries' do
      context 'title' do
        it 'is valid at minimum length (16 chars)' do
          question = build(:question, title: 'a' * 16)
          expect(question).to be_valid
        end

        it 'is invalid below minimum (15 chars)' do
          question = build(:question, title: 'a' * 15)
          expect(question).to_not be_valid
          expect(question.errors[:title]).to include('is too short (minimum is 16 characters)')
        end

        it 'is valid at maximum length (256 chars)' do
          question = build(:question, title: 'a' * 256)
          expect(question).to be_valid
        end

        it 'is invalid above maximum (257 chars)' do
          question = build(:question, title: 'a' * 257)
          expect(question).to_not be_valid
          expect(question.errors[:title]).to include('is too long (maximum is 256 characters)')
        end
      end

      context 'body' do
        it 'is valid at minimum length (32 chars)' do
          question = build(:question, body: 'b' * 32)
          expect(question).to be_valid
        end

        it 'is invalid below minimum (31 chars)' do
          question = build(:question, body: 'b' * 31)
          expect(question).to_not be_valid
          expect(question.errors[:body]).to include('is too short (minimum is 32 characters)')
        end

        it 'is valid at maximum length (1024 chars)' do
          question = build(:question, body: 'b' * 1024)
          expect(question).to be_valid
        end

        it 'is invalid above maximum (1025 chars)' do
          question = build(:question, body: 'b' * 1025)
          expect(question).to_not be_valid
          expect(question.errors[:body]).to include('is too long (maximum is 1024 characters)')
        end
      end
    end
  end
  describe 'uniqueness' do
    it 'does not allow duplicate titles' do
      original = create(:question)

      duplicate = build(:question, title: original.title)
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:title]).to include('has already been taken')
    end

    it 'allows same title after deletion' do
      question = create(:question)
      saved_title = question.title
      question.destroy

      new_question = build(:question, title: saved_title)
      expect(new_question).to be_valid
    end
  end

  context 'dependent destroy' do
    it { should have_many(:answers).dependent(:destroy) }
  end

  describe 'database columns' do
    it { should have_db_column(:title).of_type(:string).with_options(null: false) }
    it { should have_db_column(:body).of_type(:text).with_options(null: false) }
    # Проверим когда доавлю user_id
    # it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'index on db' do
    it { should have_db_index(:title) }
    it { should have_db_index(:created_at) }
  end
end
