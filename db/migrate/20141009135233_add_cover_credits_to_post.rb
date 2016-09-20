class AddCoverCreditsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :cover_credits, :string
  end
end
