class Order < ActiveRecord::Base

  acts_as_paranoid

  include PdfUtils::OrderPdfUtil

  has_many :items
  has_many :order_tags
  has_many :tags, through: :order_tags

  validates :name, presence: true
  validates :tel, presence: true
  validates :code, presence: true

  # has_paper_trail

  def self.getConn params
    conn = [[]]

    if params[:name].to_s.strip.present?
      conn[0] << 'orders.name like ?'
      conn << "%#{params[:name].to_s.strip}%"
    end

    if params[:code].to_s.strip.present?
      conn[0] << 'orders.code like ?'
      conn << "%#{params[:code].to_s.strip}%"
    end

    if params[:total_amout_from].to_s.strip.present?
      conn[0] << 'orders.total_amout >= ?'
      conn << "#{params[:total_amout_from].to_s.strip}"
    end

    if params[:total_amout_to].to_s.strip.present?
      conn[0] << 'orders.total_amout <= ?'
      conn << "#{params[:total_amout_to].to_s.strip}"
    end

    conn[0] = conn[0].join(' and ')
    conn.flatten!
    conn
  end

end
