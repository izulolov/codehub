class CreateAnswers < ActiveRecord::Migration[7.2]
  def change
    create_table :answers do |t|
      t.text :body, null: false, comment: "Answer body"

      t.timestamps
    end

    add_index :answers, :body
    add_index :answers, :created_at
  end
end
