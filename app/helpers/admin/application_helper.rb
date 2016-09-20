module Admin::ApplicationHelper

  def form_buttons(form, cancel_path: nil, submit_label: 'Save')
    content_tag('div', class: 'form-actions fluid') do
      content_tag('div', class: 'col-md-offset-2 col-md-10') do
        result = []

        result << form.button(:submit, submit_label, class: 'green')
        if cancel_path
          result << link_to('Cancel', cancel_path, class: 'btn btn-lg default')
        end

        raw(result.join)
      end
    end
  end

  def show_property(object, property, label: nil, value: nil, raw: false)
    label ||= I18n.t("activerecord.attributes.#{object.class.name.underscore}.#{property}")
    value ||= object.send(property)

    render 'client/helpers/show_property', label: label, value: value, raw: raw
  end

  def paginate_list(collection)
    will_paginate collection, renderer: BootstrapPagination::Rails
  end

  def paginate_per
    items_per_page = [20, 50, 100]
    current_per_page = params[:per_page].try(:to_i) || items_per_page.first

    r = [content_tag(:li, raw('<span>Show</span>'))]
    items_per_page.each do |per_page|
      path = "#{request.path}?#{request.query_parameters.merge(per_page: per_page).to_query}"
      r << (content_tag :li, (link_to per_page, path, class: "btn btn-xs #{'active' if current_per_page == per_page}"))
    end

    content_tag :ul, raw(r.join), class: 'paginate-per'
  end

  def ltime(time)
    time ? l(time, format: :post_edit) : ''
  end

  def prepare_for_html(message)
    if message.present? && message.is_a?(String)
      message.gsub("\r\n", '<br>')
    else
      message
    end
  end
end