class AddFieldsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :name, :string
    add_column :articles, :text, :string
  end
end
