Factory.define :setting do |s|
  s.association :frame
  
  s.name        'Test Setting'
  s.value       'Test Value'
end