class Order < ActiveRecord::Base

  acts_as_paranoid

  include PdfUtils::OrderPdfUtil

  has_many :items

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true

  # has_paper_trail

end
