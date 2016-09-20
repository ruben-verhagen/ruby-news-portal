class ListInput < SimpleForm::Inputs::CollectionCheckBoxesInput

  def input
    label_method, value_method = detect_collection_methods
    iopts = {
        :checked => 1,
        :item_wrapper_tag => 'div',
        :item_wrapper_class => 'field',
        :collection_wrapper_tag => 'div',
        :collection_wrapper_class => 'grouped inline fields'
    }
    return @builder.send(
        "collection_check_boxes",
        attribute_name,
        collection,
        value_method,
        label_method,
        iopts,
        input_html_options,
        &collection_block_for_nested_boolean_style
    )
  end # method

  protected

  def build_nested_boolean_style_item_tag(collection_builder)
    tag = String.new
    tag << '<div class="ui radio checkbox">'.html_safe
    tag << collection_builder.check_box + collection_builder.label
    tag << '</div>'.html_safe
    return tag.html_safe
  end # method
end