class AddQuestionToAnswers < ActiveRecord::Migration[7.2]
  def change
    add_reference :answers, :question, null: false, foreign_key: true
  end
end
