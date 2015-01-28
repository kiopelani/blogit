class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :text
      t.string :img_src, default: 'http://www.hdwallpaperscool.com/wp-content/uploads/2014/09/road-and-cloudy-blue-sky-new-desktop-wallpapers-in-high-resolution-fullscreen.jpg'
      t.references :blog, index: true

      t.timestamps
    end
  end
end
