module LinksHelper
  def change_status_text(status)
    return "Mark as Unread" if status
    "Mark as Read"
  end

  def status(status)
    return "read" if status
    "unread"
  end

  def swap_status(status)
    !status
  end
end
