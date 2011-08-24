class DropShipOrder < ActiveRecord::Base

  belongs_to :supplier
  has_many   :line_items, :class_name => "DropShipLineItem"

  validates :supplier_id, :presence => true


  state_machine :initial => 'active' do
  
    before_transition :on => :deliver, :do => :set_sent_at
    before_transition :on => :recieve, :do => :set_recieved_at
    before_transition :on => :process, :do => :set_processed_at
  
    event :deliver do
      transition :active => :sent
    end
  
    event :recieve do
      transition :sent => :recieved
    end
    
    event :process do
      transition :recieved => :complete
    end 
       
  end
  
  
  def add(new_items)
    new_items = [ new_items ].flatten.reject{|li| li.supplier_id.nil? || li.supplier_id != self.supplier_id }
    attributes = []
    new_items.group_by(&:variant_id).each do |variant_id, items|
      quantity = items.map(&:quantity).inject(:+)
      attributes << items.first.drop_ship_attributes.update(:quantity => quantity)
    end
    self.line_items.create(attributes)
  end
  

  private
  
    def set_sent_at
      self.sent_at = Time.now
    end
    
    def set_recieved_at
      self.recieved_at = Time.now
    end
    
    def set_processed_at
      self.processed_at = Time.now
    end  

end
