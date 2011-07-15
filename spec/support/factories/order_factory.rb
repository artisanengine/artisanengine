Factory.define :order do |o|
  o.association :frame
end

Factory.define :line_item do |l|
  l.association :order
  l.association :variant
end