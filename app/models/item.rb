class Item < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :article

  validates :name, presence: true
  validates :width, presence: true
  validates :height, presence: true
  validates :number, presence: true
  validates :punch_count, presence: true
  validates :punch_price, presence: true
  validates :dig_angle_count, presence: true
  validates :dig_angle_price, presence: true

  PUNCH_PRICE = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]         #打孔的价钱设定
  DIG_ANGLE_PRICE = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]     #挖角的价钱设定

  def self.punch_price_select
    PUNCH_PRICE
  end

  def self.dig_angle_price_select
    DIG_ANGLE_PRICE
  end

end
