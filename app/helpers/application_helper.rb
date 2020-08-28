module ApplicationHelper

  def flash_message(name, msg)
      flash[name] ||= []
      flash[name] << msg
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, 
      {:sort => column, :direction => direction, :type => params[:type], :business_subtype => params[:business_subtype], :service_type => params[:service_type]},
      {:class => css_class}
  end

  def get_user_role(user)
    case
    when user.admin_role?
      return "admin"
    when user.supervisor_role?
      return "supervisor"
    when user.sales_role?
      return "sales"
    else
      return "user"
    end
  end
end
