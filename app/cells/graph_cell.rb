class GraphCell < FrontendCell
  helper ApplicationHelper

  def show(options={})
    @value = options[:value]
    @width = options[:width] || 285
    @min_value = options[:min_value] || 1
    @max_value = options[:max_value] || 10
    @labels = options[:labels] || false

    @min_value, @max_value = [@min_value, @max_value].minmax
    unless @min_value <= @value && @value <= @max_value
      @value = @min_value
    end
    @normalized_value = (@value - @min_value)/(@max_value - @min_value)

    @angel = ((@normalized_value*224)-156).to_i
    @fill_color = case @normalized_value
                    when 0.0..0.3 then '#ea2f43'
                    when 0.3..0.65 then '#fac171'
                    when 0.65..1.0 then '#96be40'
                  end

    render
  end
end