class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :image_path
      t.text :text

      t.timestamps null: false
    end
  end
end
