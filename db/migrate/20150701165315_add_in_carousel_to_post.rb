class AddInCarouselToPost < ActiveRecord::Migration
  def change
    add_column :posts, :in_carousel, :boolean, default: false
  end
end
