class FussyUrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.present? && !value.match(/\Ahttps?:\/\//)
      value = 'http://' + value
    end

    begin
      return true if value.empty?
      uri = URI.parse(value)
      resp = uri.kind_of?(URI::HTTP)
    rescue URI::InvalidURIError
      resp = false
    end

    unless resp == true
      record.errors[attribute] << (options[:message] || 'не является URL-ом')
    end
  end
end