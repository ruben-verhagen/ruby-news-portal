class Graph < ActiveRecord::Base
  extend FriendlyId
  include Concerns::Sluggable

  validates_presence_of :name, :existing, :spread_min, :spread_max, :existing, :average_6, :average_9, :average_12,
            :period_3_name, :period_6_name, :period_9_name, :period_12_name

  validates :spread_min, :spread_max, :existing,
            :median_3, :median_6, :median_9, :median_12, :average_3, :average_6, :average_9, :average_12,
            :high_3, :high_6, :high_9, :high_12, :low_3, :low_6, :low_9, :low_12,
            numericality: { only_float: true }, allow_blank: true

  protected

  def slug_source
    name
  end
end
