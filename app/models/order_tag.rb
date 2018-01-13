class OrderTag < ApplicationRecord

  # acts_as_paranoid

  belongs_to :order
  belongs_to :tag

end
