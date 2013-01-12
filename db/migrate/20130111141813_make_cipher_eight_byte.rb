class MakeCipherEightByte < ActiveRecord::Migration
  def change
    change_column :matches, :cipher, :integer, :limit => 8
  end

end
