class HTMLUtils
  def self.decode_special_chars(string)
    return string unless string.include? '&'
    enc = string.encoding

    HTMLEntities.new.decode string

  end
end