module ApplicationHelper
  def noty_class(noty_name)
    case noty_name
    when 'notice', 'success'
      'alert-success'
    else
      'alert-danger'
    end
  end
end
