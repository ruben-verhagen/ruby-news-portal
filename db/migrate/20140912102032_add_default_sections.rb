class AddDefaultSections < ActiveRecord::Migration
  def up
    PostSection.destroy_all
    PostSection.create([
      { code: 'euro_tower', name: 'Euro Tower'},
      { code: 'berlay_mouse', name: 'Berlay Mouse'},
      { code: 'brussels_cutting_room', name: 'Brussels Cutting-room'},
    ])
  end
end
