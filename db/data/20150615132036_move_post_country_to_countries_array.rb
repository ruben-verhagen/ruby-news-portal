class MovePostCountryToCountriesArray < SeedMigration::Migration
  def up
    Post.all.each do |post|
      if post.country.present?
        post.countries.push post.country
        post.save
      end
    end
  end

  def down
    Post.all.each do |post|
      post.country = post.countries.first
    end
  end
end
