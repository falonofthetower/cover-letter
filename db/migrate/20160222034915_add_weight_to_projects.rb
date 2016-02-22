class AddWeightToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :weight, :integer
  end
end
