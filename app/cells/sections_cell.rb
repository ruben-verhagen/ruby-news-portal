class SectionsCell < FrontendCell
  def sidebar
    @user = current_user
    @sections = [
      {
        section: (euro_tower_section = PostSection.find_by_code(:euro_tower)),
        posts: apply_posts_scope(euro_tower_section.posts.latest).limit(3),
        icon_class: 'icon-tower',
        image_url: (euro_tower_section.cover.url(:sidebar) if euro_tower_section.cover.path)
      },
      {
        section: (berlay_mouse_section = PostSection.find_by_code(:berlay_mouse)),
        posts: apply_posts_scope(berlay_mouse_section.posts.latest).limit(3),
        icon_class: 'icon-mouse',
        image_url: (berlay_mouse_section.cover.url(:sidebar) if berlay_mouse_section.cover.path)
      },
      {
        section: (brussels_cutting_room_section = PostSection.find_by_code(:brussels_cutting_room)),
        posts: apply_posts_scope(brussels_cutting_room_section.posts.latest).limit(3),
        icon_class: 'icon-people',
        image_url: (brussels_cutting_room_section.cover.url(:sidebar) if brussels_cutting_room_section.cover.path)
      },
    ]

    render
  end
end
