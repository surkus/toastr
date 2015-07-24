class Oat < ActiveRecord::Base

  def breakfast
    sleep 2 unless Rails.env.test?
    {oat: :meal}
  end
  # only update if this class is updated since the toast was calculated
  has_toast :breakfast

  def daily_report
    sleep 2 unless Rails.env.test?
    {different: :result}
  end
  # update if ever older than 1 day
  has_toast :daily_report, expire_in: 1.day

  def special
    sleep 2 unless Rails.env.test?
    {very: :special}
  end
  # update on arbitrary block. example updates toast every time it's accessed if 
  # parent object was created on 8th day of the month
  has_toast :special, expire_if: ->(toast) { toast.parent.created_at.day == 8 }

end
