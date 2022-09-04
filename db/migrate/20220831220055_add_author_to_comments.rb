class AddAuthorToComments < ActiveRecord::Migration[6.1]
  def change

    add_column :comments, :author, :text

  end
end
