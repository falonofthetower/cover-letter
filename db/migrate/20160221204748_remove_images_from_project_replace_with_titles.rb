class RemoveImagesFromProjectReplaceWithTitles < ActiveRecord::Migration
  def change
    rename_column :projects, :image_path, :title
  end
end
