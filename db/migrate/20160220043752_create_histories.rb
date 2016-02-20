class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :subject
      t.text :text

      t.timestamps null: false
    end
  end
end
