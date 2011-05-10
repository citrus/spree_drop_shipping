class DropShipOrder < ActiveRecord::Base

  belongs_to :suppler
  has_many   :line_items, :class_name => "DropShipLineItem"

end