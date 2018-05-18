class CreateTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :templates do |t|

    	t.string :name
      t.string :filepath
      t.integer :number_of_signees
 
      t.references :user
      t.timestamps
    end
  end
end
