class Admin::PostsController < AdminController
  before_action :find_post, only: [:edit, :update, :destroy]

  def select_type
  end

  def index
    posts = Post.ranked

    @q = posts.search(params[:q])
    @posts = @q.result.includes(:tags).paginate(paginate_params)
  end

  def new
    @post = Post.new
    @post.published_at = Time.zone.now
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      @post.update_attribute :rank_position, params[:post][:rank_position].to_i
      process_post_on_success_update(@post)
    else
      flash[:error] = "Can't create a post. Checkout the errors below"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update_attributes(post_params)
      if params[:post][:author_ids].present?
        @post.author_ids = []

        @post.author_ids = params[:post][:author_ids_ordered].split(',')
      end
      if params[:post][:rank_position].present?
        @post.update_attribute :rank_position, params[:post][:rank_position].to_i
      end

      process_post_on_success_update(@post)
    else
      flash[:error] = 'Please checkout the post updating errors'
      render 'edit'
    end
  end

  def new_twitter_alert
    @post = Post.friendly.find(params[:post_id])
    @twitter_alert_form = Admin::TwitterAlertForm.new
    render 'twitter_alerts'
  end

  def alert_via_twitter
    @post = Post.friendly.find(params[:post_id])
    @twitter_alert_form = Admin::TwitterAlertForm.new(twitter_alert_form_params)

    if @twitter_alert_form.valid? && TwitterAccount.has_twitter_account?
      begin
        TwitterPoster.new(twitter_alert_form_params[:twitter_account_id]).tweet_post(@post, @twitter_alert_form.twitter_text)

        redirect_to edit_admin_post_path(@post), flash: { success: 'Post was successfully tweeted' }

        return
      rescue StandardError => e
        flash[:error] = "Twitter: #{e.message}"
      end
    else
      flash[:error] = "Can't tweet. You have no twitter account connected or tweet text is empty"
    end

    render 'twitter_alerts'
  end

  def destroy
    @post.destroy if @post.present?

    redirect_to admin_posts_path, flash: { success: 'Post was successfully removed.' }
  end

  protected

  def process_post_on_success_update(post)
    redirect_path = edit_admin_post_path(post)
    case params[:commit]
      when 'Save'
        flash[:success] = 'Post was successfully updated'
      when 'Preview'
        session[:post_preview_id] = @post.id
        redirect_path = post_path(post)
      when 'Publish'
        post.published = true
        post.published_at ||= Time.zone.now

        flash[:success] ||= 'Post was successfully published'

        post.save
    end

    redirect_to redirect_path
  end



  def find_post
    @post = Post.friendly.find(params[:id])
  end

  def post_params
    p = params.require(:post).permit(:place, :cover, :carousel_rank_position, :in_carousel, :remove_cover,
                                 :cover_remove, :headline, :byline, :content,
                                 :featured_level, :in_digest, :top_lede, :published, :published_at, :is_breaking_news, :authors_pick,
                                 :cover_description, :cover_credits, :video_mp4, :video_webm, :seo_title, :seo_keywords, :seo_description,
                                 :tag_list, :in_ticker, :visibility, :post_to_twitter, :in_automatic_email,
                                 author_ids: [], post_section_ids: [], countries: [])

    p
  end

  def twitter_alert_form_params
    params.require(:admin_twitter_alert_form).permit(:twitter_text, :twitter_account_id)
  end

  def Post
    Post
  end
end