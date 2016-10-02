class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_filter :html_to_pdf



  def encode_file_name(file_name)
    return if file_name.blank?
    name = file_name.split('.')
    file_name = "#{name.first}#{Time.now.strftime('%Y%m%d%H%M%S')}.#{name.last}"
    case get_brower_type(request.env["HTTP_USER_AGENT"])
      when "IE"
        file_name = url_encode(file_name)
      when "Firefox"
        file_name
      when "Safari"
        file_name
      else
        file_name = url_encode(file_name)
    end
  end

  #【引数】nil
  #【返値】nil
  #【注意】取得当前浏览器类型
  #【著作】by zy 2015/10/07
  def get_brower_type(http_user_agent)
    return "Firefox" if http_user_agent.include?("Firefox")
    return "Safari" if http_user_agent.include?("Safari")
    return "IE" if http_user_agent.include?("MSIE")
    return "IE"
  end

end
