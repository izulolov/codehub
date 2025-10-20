class Answer < ApplicationRecord
  before_validation :strip_whitespace

  validates :body, presence: true, length: { minimum: 32, maximum: 2048 }

  private

  def strip_whitespace
    self.body = body.strip if body.present?
  end
end
