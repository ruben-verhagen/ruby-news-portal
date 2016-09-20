module ApplicationHelper
  def widget(name, type=:show, *args)
    render_cell name, type, *args
  end

  def separated_countries(countries=[], separator=', ')
    countries.map {|c| EuroCountry.name_by_code(c) }.join(separator)
  end

  def site_setting(code)
    setting = SiteSetting.find_by_code(code)
    setting.value
  end

  def darken_color(hex_color, amount=0.3)
    hex_color = (hex_color || '#777777').gsub('#','')
    rgb = hex_color.scan(/../).map {|color| color.hex}
    rgb[0] -= (rgb[0].to_i * amount).round
    rgb[1] -= (rgb[1].to_i * amount).round
    rgb[2] -= (rgb[2].to_i * amount).round
    "#%02x%02x%02x" % rgb
  end
end
