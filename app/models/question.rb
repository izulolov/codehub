class Question < ApplicationRecord
  has_many :answers, dependent: :destroy

  validates :title, presence: true,
                    length: { minimum: 16, maximum: 256 },
                    uniqueness: true

  validates :body, presence: true,
                   length: { minimum: 32, maximum: 1024 }

  before_validation :strip_whitespace

  private

  def strip_whitespace
    self.title = title.strip if title.present?
    self.body = body.strip if body.present?
  end
end
