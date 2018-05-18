class CreateUserDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :user_documents do |t|

      t.boolean :submitted, default: false

      t.references :user
      t.references :document
      t.timestamps
    end
  end
end
