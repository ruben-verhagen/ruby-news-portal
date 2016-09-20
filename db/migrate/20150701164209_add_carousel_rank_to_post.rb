class AddCarouselRankToPost < ActiveRecord::Migration
  def change
    add_column :posts, :carousel_rank, :integer
  end
end
