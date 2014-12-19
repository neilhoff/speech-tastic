class ChangeProductTypeToKind < ActiveRecord::Migration
  def change
    rename_column :products, :type, :kind
  end
end
