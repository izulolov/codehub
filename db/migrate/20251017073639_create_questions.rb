class CreateQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :questions do |t|
      t.string :title, null: false, limit: 256, comment: "Question title"
      t.text :body, null: false, comment: "Question description"

      t.timestamps
    end

    add_index :questions, :title
    add_index :questions, :created_at
  end
end
