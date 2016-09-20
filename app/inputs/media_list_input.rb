class MediaListInput < SimpleForm::Inputs::CollectionCheckBoxesInput

  def input
    @thumb_method = input_html_options.delete(:thumb_method)
    @version = input_html_options.delete(:version)
    @input_method = input_html_options.delete(:input_method) || :check_box
    collection_string = @input_method == :check_box ? "collection_check_boxes" : "collection_radio_buttons"
    label_method, value_method = detect_collection_methods
    input_options[:item_wrapper_tag] = nil
    template.content_tag :div, class: 'list-wrapper' do
      template.content_tag :table, class: 'table table-advanced' do
        template.content_tag :tbody do
          @builder.send(collection_string,
                        attribute_name, collection, value_method, label_method,
                        input_options, input_html_options,
                        &collection_block_for_nested_boolean_style
          )
        end
      end
    end
  end

  def build_nested_boolean_style_item_tag(collection_builder)
    template.content_tag :tr do
      input = template.content_tag :td, class: 'w-30' do
        collection_builder.send(@input_method)
      end
      name = template.content_tag :td do
        collection_builder.text
      end

      input + name
    end
  end
end