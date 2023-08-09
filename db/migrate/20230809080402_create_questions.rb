class CreateQuestions < ActiveRecord::Migration[7.0]
  def up
    create_enum :question_status, %w[unanswered answered solved]

    create_table :questions do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.text :body, null: false
      t.enum :status,
             enum_type: :question_status,
             null: false,
             default: 'unanswered'

      t.timestamps
    end
  end

  def down
    drop_table :questions

    execute <<-SQL
      DROP TYPE question_status;
    SQL
  end
end
