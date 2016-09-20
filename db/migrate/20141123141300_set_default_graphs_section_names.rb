class SetDefaultGraphsSectionNames < ActiveRecord::Migration
  def up
    Graph.all.each do |graph|
      graph.update_attributes(period_3_name: '3 Months', period_6_name: '6 Months', period_9_name: '9 Months', period_12_name: '12 Months')
    end
  end
end
