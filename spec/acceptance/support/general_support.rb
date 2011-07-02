# ------------------------------------------------------------------
# Notifications

def page_should_have_alert
  page.should have_selector '.alert'
end

def page_should_have_notice
  page.should have_selector '.notice'
end

# ------------------------------------------------------------------
# Interfaces

def development_interface
  '/develop'
end