class AddOpinionsSection < ActiveRecord::Migration
  def up
    PostSection.create(name: 'Opinions', code: :opinions)
  end
end
