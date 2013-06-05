class CatRentalRequest < ActiveRecord::Base
  attr_accessible :begin_date, :cat_id, :end_date, :status

  validates :begin_date, :cat_id, :end_date, :status, :presence => true
  validate  :valid_start_date

  belongs_to :cat

  def approve
    self.deny_all_other_requests
  end

  def valid_start_date
    if self.begin_date < Date.today
      errors[:begin_date] << "Date is in the past"
    elsif self.begin_date > self.end_date
      errors[:begin_date] << "end date must be after begin date"
    end
  end

  def deny_all_other_requests
    current_requests = CatRentalRequest.where(:cat_id => self.cat_id)
    current_requests.each do |request|
      self.begin_date.upto(self.end_date) do |date|
        request.begin_date.upto(request.end_date) do |date2|
          if date2 == date && request.id != self.id
            request.status = 'denied'
            request.save
          end
        end
      end
    end
  end
end
