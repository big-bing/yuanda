module ApplicationHelper

  def switch_key(key)
      new_key = key
      new_key =  'warning' if key.to_s == 'alert'
      new_key =  'danger' if key.to_s == 'error'
      new_key =  'success' if key.to_s == 'notice'
      new_key
    end

end
