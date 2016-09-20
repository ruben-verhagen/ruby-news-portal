class EmailAlertSchedule < ActiveRecord::Base
  serialize :user_groups, Array
  serialize :days_of_week, Array

  INTERVAL = 120

  attr_accessor :form_send_at

  has_many :automatic_email_alerts, dependent: :destroy

  before_validation :convert_form_data
  validates_presence_of :form_send_at, :greeting_message, :user_groups, :days_of_week

  validates_length_of :greeting_message, maximum: 10_000

  def self.all_days_of_week
    [ ['Sunday', 0],
      ['Monday', 1],
      ['Tuesday', 2],
      ['Wednesday', 3],
      ['Thursday', 4],
      ['Friday', 5],
      ['Saturday', 6] ]
  end

  def self.human_day_of_week(number)
    self.all_days_of_week.select {|schedule| schedule[-1] == number.to_i}.first[0]
  end

  def days_of_week=(value)
    super(value.reject(&:empty?))
  end

  def self.current
    self.all.each do |schedule|
      s = IceCube::Schedule.new(schedule.send_at, duration: INTERVAL)
      schedule.days_of_week.each do |day_of_week|
        s.add_recurrence_rule IceCube::Rule.weekly.day(day_of_week.to_i)
      end

      if s.occurring_at? Time.zone.now
        return schedule
      end
    end

    return false
  end

  def user_groups=(value)
    super(value.reject(&:empty?))
  end

  def name
    #self.class.all_days_of_week[days_of_week][0]}
    "At #{I18n.l(send_at, format: :time)}"
  end

  def convert_form_data
    if self.form_send_at
      self.send_at = Time.zone.parse(self.form_send_at)
    end
  end

  def prepare_form_data
    self.form_send_at = self.send_at.try(:strftime, '%I:%M %p')
  end
end
