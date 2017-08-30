class CreateThemes < ActiveRecord::Migration[5.1]
  def change
    create_table :themes do |t|
      t.string :name
      t.string :css_file_name
      t.string :js_file_name

      t.timestamps
    end
  end
end
