class AdminConstraint
  def matches?(request)
    current_user && current_user.is_admin?
  end
end
