module ApplicationHelper

    def flash_message(name, msg)
        flash[name] ||= []
        flash[name] << msg
    end

    def sortable(column, title = nil)
      title ||= column.titleize
      css_class = column == sort_column ? "current #{sort_direction}" : nil
      direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
      link_to title, {:sort => column, :direction => direction, :type => params[:type]}, {:class => css_class}
    end

end
