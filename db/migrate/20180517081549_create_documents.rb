class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|

      t.string :status

      t.references :template
      t.timestamps
    end
  end
end
