module ApplicationHelper

    def flash_message(name, msg)
        flash[name] ||= []
        flash[name] << msg
    end


end
