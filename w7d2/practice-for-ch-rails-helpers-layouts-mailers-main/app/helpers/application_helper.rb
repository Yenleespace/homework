module ApplicationHelper
  def auth_token # post 할때 보안을 위해서 집어 넣는 것
    "<input
      type='hidden'
      name='authenticity_token'
      value='#{form_authenticity_token}'
    />".html_safe
  end
end