class AddWeightToReasons < ActiveRecord::Migration
  def change
    add_column :reasons, :weight, :integer
  end
end
