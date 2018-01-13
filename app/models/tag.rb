class Tag < ApplicationRecord

  # acts_as_paranoid

  include PdfUtils::TagPdfUtil

  has_many :order_tags
  has_many :orders, through: :order_tags

  def self.getConn params
    conn = [[]]

    if params[:name].to_s.strip.present?
      conn[0] << 'tags.name like ?'
      conn << "%#{params[:name].to_s.strip}%"
    end

    if params[:number_from].to_s.strip.present?
      conn[0] << 'tags.number >= ?'
      conn << "#{params[:number_from].to_s.strip}"
    end

    if params[:number_to].to_s.strip.present?
      conn[0] << 'tags.number <= ?'
      conn << "#{params[:number_to].to_s.strip}"
    end

    conn[0] = conn[0].join(' and ')
    conn.flatten!
    conn
  end

end
