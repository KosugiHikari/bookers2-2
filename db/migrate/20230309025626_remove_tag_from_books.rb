class RemoveTagFromBooks < ActiveRecord::Migration[6.1]
  def change
    remove_column :books, :tag, :string
  end
end
