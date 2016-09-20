require 'prawn'
require 'faker'

require 'html_utils'

module Prawn
  class Document
    def reflow_column_box(*args, &block)
      init_column_box(block) do |parent_box|
        map_to_absolute!(args[0])
        @bounding_box = ReflowColumnBox.new(self, parent_box, *args)
      end
    end

    private

    class ReflowColumnBox < ColumnBox
      def move_past_bottom
        @current_column = (@current_column + 1) % @columns
        @document.y = @y
        if 0 == @current_column
          @y = @parent.absolute_top
          @document.start_new_page
        end
      end
    end
  end
end

class ArticlePdfGenerator < Prawn::Document
  MARGIN = 30

  def initialize(posts, options={}, &block)
    options.merge!({ page_size: 'A4', margin: MARGIN})
    @date = options.delete(:date) || ''
    doc = super(options, &block)

    @posts = posts
    @first_post = true

    apply_fonts

    draw_doc_cover

    @posts.each_with_index do |post, index|
      draw_post(post)
      unless index == @posts.count-1
        #move_down 40
        start_new_page
      end
    end

    doc
  end

  protected

  def draw_doc_cover
    fill_color '005BAB'
    fill_rectangle [-MARGIN, bounds.height + MARGIN], bounds.width + 2*MARGIN, bounds.height + 2*MARGIN

    fill_color 'ffffff'
    move_down 150
    text @date || '', size: 18

    move_down 32
    text 'Weekly Briefing', size: 47

    move_down 10
    text 'Euro Insight', size: 18


    start_new_page
  end

  def draw_post(post)

    draw_cover_photo(post)
    draw_details(post)
    draw_title(post)
    draw_content(post)

    @first_post = false
  end

  def draw_title(post)
    text post.headline, align: :left, size: 20.5, leading: 5, color: '005CAB'
    move_down 20

    text post.byline,   align: :left, size: 20.5, leading: 5, color: '808285'
    move_down 8
  end


  def draw_details(post)
    text post.authors.map { |a| a.name }.join(', '), size: 8, color: '808284'
    move_down 16
  end

  def draw_cover_photo(post)
    #if  @first_post
    #  image Rails.root.join('docs', 'pdf-templates', 'first-page-cover.png'), width: bounds.width
    #  move_down 40
    #els
    if post.cover.path
      image post.cover.pdf.path, width: bounds.width
      move_down 40
    end
  end

  def draw_content(post)
    fill_color '231F20'

    reflow_column_box([0, cursor], :columns => 2, :width => bounds.width) do
      text prepare_content(post.content), inline_format: true, size: 9.5, leading: 3
    end
  end


  protected

  def prepare_content(content)
    HTMLUtils::decode_special_chars HTML::FullSanitizer.new.sanitize(content)
  end

  def apply_fonts
    fonts_path = Rails.root.join('docs', 'fonts')

    font_families.update(
      'News Gothic' => {
          light: fonts_path.join('NewsGothic-Light.ttf'),
          normal: fonts_path.join('NewsGothic-Regular.ttf'),
          bold: fonts_path.join('NewsGothic-Bold.ttf')
      },
    )

    font 'News Gothic'
  end
end