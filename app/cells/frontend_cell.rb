class FrontendCell < Cell::Rails
  include Devise::Controllers::Helpers

  def apply_posts_scope(scope)
    scope.published
  end
end