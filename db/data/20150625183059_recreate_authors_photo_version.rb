class RecreateAuthorsPhotoVersion < SeedMigration::Migration
  def up
    Author.all.each do |author|
      author.photo.recreate_versions!(:main) if author.photo.url
    end
  end
  def down

  end
end
