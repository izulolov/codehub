class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true, length: { minimum: 32, maximum: 2048 }

  before_validation :strip_whitespace

  private

  def strip_whitespace
    self.body = body.strip if body.present?
  end
end
