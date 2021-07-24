class Card < ApplicationRecord
  enum level: {
    "0" => "always",
    "1" => "5s",
    "2" => "25s",
    "3" => "2min",
    "4" => "10min",
    "5" => "1h",
    "6" => "5h",
    "7" => "1d",
    "8" => "5d",
    "9" => "25d",
    "10" => "4m",
    "11" => "never"
  }

  has_one :words_pair, dependent: :destroy

  accepts_nested_attributes_for :words_pair

  after_create_commit do
    CardsJob.perform_later("add", self)
  end

  def up
    if self.level != "11"
      self.level = self.level.next
      save
    end
  end

  def drop
    self.level = "1"
    save
  end

  def never
    self.level = "11"
    save
  end

  def never?
    self.level == "11"
  end

  def to_time_duration
    time_interval = Card.levels[self.level].scan(/(\d{1,2})(\w{1,3})/).first
    time = time_interval[0]
    raw_unit = time_interval[1]

    time_unit =
      case raw_unit
      when "s"
        "second"
      when "h"
        "hour"
      when "min"
        "minute"
      when "d"
        "day"
      when "m"
        "month"
      end

    eval("#{time}.#{time_unit}")
  end
end
