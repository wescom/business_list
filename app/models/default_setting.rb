class DefaultSetting < ApplicationRecord

  has_attached_file :homepage_banner_image, 
    :styles => { 
      :small => ["200x200>",:jpg],
      :medium => ["600x600>",:jpg],
      :large => ["1000x1000>",:jpg]
    },
    :url => "/images/homepage_images/:id/:style_:basename.:extension",  
    :path => ":rails_root/public/images/homepage_images/:id/:style_:basename.:extension",
    :default_url => '/images/no-image.jpg'

    validates_attachment_content_type :homepage_banner_image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

    has_attached_file :homepage_general_instruction_image, 
      :styles => { 
        :small => ["200x100>",:jpg],
        :medium => ["600x300>",:jpg],
        :large => ["1000x700>",:jpg]
      },
      :url => "/images/homepage_images/:id/:style_:basename.:extension",  
      :path => ":rails_root/public/images/homepage_images/:id/:style_:basename.:extension",
      :default_url => '/images/no-image.jpg'

      validates_attachment_content_type :homepage_general_instruction_image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

      has_attached_file :homepage_registration_image, 
        :styles => { 
          :small => ["200x100>",:jpg],
          :medium => ["600x300>",:jpg],
          :large => ["1000x500>",:jpg]
        },
        :url => "/images/homepage_images/:id/:style_:basename.:extension",  
        :path => ":rails_root/public/images/homepage_images/:id/:style_:basename.:extension",
        :default_url => '/images/no-image.jpg'

        validates_attachment_content_type :homepage_registration_image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
end
