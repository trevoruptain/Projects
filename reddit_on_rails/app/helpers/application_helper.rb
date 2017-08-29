module ApplicationHelper

  def auth_token
    auth_token = '<input type="hidden" '
    auth_token += 'name="authenticity_token" '
    auth_token += 'value="<%= form_authenticity_token %>">'

    auth_token.html_safe
  end
end
