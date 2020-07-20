class CheckOutLog < ApplicationRecord
  validates :user_id, presence: true
  validates :book_id, presence: true
  
  belongs_to :user
  belongs_to :book

  def overdue?
    # Due date is 14 days from check_out_date
    days = (Date.today - self.check_out_date)
    if days > 14
      true
    else
      false
    end
  end

  def due_date
    (self.check_out_date + 14.days).strftime("%m/%d/%Y")
  end
end
