class AddDefaultGraph < ActiveRecord::Migration
  class Graph < ActiveRecord::Base
    attr_accessor :period_3_name, :period_6_name, :period_9_name, :period_12_name
  end

  def up
    Graph.create(name: 'Euro Poll', code: :euro_poll, existing: 0.0, spread_min: 1, spread_max: 10,
                 average_3: 1, average_6: 3, average_9: 6, average_12: 8)
  end
end
