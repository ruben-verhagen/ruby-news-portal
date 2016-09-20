class EuroCountry
  @@data = { 'Eurozone' => 'Eurozone', 'EU' => 'EU', 'Europe' => 'Europe' }
  @@data.merge! ActionView::Helpers::FormOptionsHelper::COUNTRIES.map { |data| [data[1], data[0]] }.to_h

  @@select_data = @@data.collect { |code, name| [name, code] }

  def self.select_data
    @@select_data
  end

  def self.name_by_code(code)
    @@data[code]
  end
end