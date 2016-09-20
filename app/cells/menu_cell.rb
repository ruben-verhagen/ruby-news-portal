class MenuCell < FrontendCell
  include Devise::Controllers::Helpers

  def sidebar
    @root_sections = PostSection.root.in_menu.order(:created_at)
    render
  end
end
