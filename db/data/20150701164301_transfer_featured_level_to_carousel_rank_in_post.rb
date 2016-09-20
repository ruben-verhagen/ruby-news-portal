class TransferFeaturedLevelToCarouselRankInPost < SeedMigration::Migration
  def up
    (5.downto 1).each do |level|
      post = Post.published.with_image.where(featured_level: level).order(published: :desc).first
      if post.present?
        post.carousel_rank_position = 0
        post.in_carousel = true

        post.save
      end
    end
  end

  def down

  end
end
