class CreateReasons < ActiveRecord::Migration
  def change
    create_table :reasons do |t|
      t.string :header
      t.text :text

      t.timestamps null: false
    end
  end
end
