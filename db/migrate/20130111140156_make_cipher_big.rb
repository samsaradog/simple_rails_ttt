class MakeCipherBig < ActiveRecord::Migration
  def up
    change_column :matches, :cipher, :bigint
  end

end
