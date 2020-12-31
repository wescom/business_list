class DefaultSettingsEmail < ApplicationRecord
  
  # Define email templates available. When adding new functionality, add a template name to this list. Then code Mailer functionality for this name.
  EMAIL_TEMPLATES = ["Welcome", "Business Updated", "Business Waiting For Approval"]
end
