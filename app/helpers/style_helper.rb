module StyleHelper
  mattr_accessor :body_classes
  @@body_classes = []
  
  mattr_accessor :body_ids
  @@body_ids = []
  
  def add_body_class( value )
    self.body_classes += [ value ] unless self.body_classes.include? value
  end
  
  def add_body_id( value )
    self.body_ids += [ value ] unless self.body_ids.include? value
  end
end