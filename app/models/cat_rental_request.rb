class CatRentalRequest < ActiveRecord::Base
  attr_accessible :cat_id, :start_date, :end_date, :status

  before_validation(on: :create) do
      self.status ||= "PENDING"
  end

  validates :cat_id, :start_date, :end_date, :presence => true
  validates :status, inclusion: { in: %w(APPROVED DENIED PENDING) }
  validate :overlapping_approved_requests, :date_makes_sense

  belongs_to :cats

  def parse_date(date)
    sd = Date._parse(date)
    Date.new(sd[:mday],sd[:mon])
  end

  def date_makes_sense
    if parse_date(start_date) > parse_date(end_date)
      errors.add(:end_date, "end date can't be before start date")
    end
  end


  def approve!
    self.status = "APPROVED"
    self.save
  end

  def deny!
    self.status = "DENIED"
    self.save
  end

  def overlapping_pending_requests
    all_requests = overlapping_requests
    overlap = false
    all_requests.each do |request|
      if request.status == "APPROVED"
        overlap = true
      end
    end

    if overlap
      deny!
    else
      approve!
    end
  end

  def overlapping_requests
    our_start = parse_date(start_date)
    our_end = parse_date(end_date)
    overlapping_requests = []
    requests = CatRentalRequest.where(:id => cat_id)
    unless requests.nil?
      requests.each do |request|
        s = parse_date(request.start_date)
        e = parse_date(request.end_date)
        #if (s <= our_start && e >= our_start) || (our_start <= s && our_end >= s)
        unless (s <= our_start && e <= our_end) || (s >= our_start && e >= our_end)
				  overlapping_requests << request
        end
      end
    end
    overlapping_requests - [self]
  end

  def overlapping_approved_requests
    all_requests = overlapping_requests
    overlap = false
    all_requests.each do |request|
      if request.status == "APPROVED"
        overlap = true
      end
    end

    if overlap
      errors.add(:end_date, "overlapping request")
    end

  end

  def self.decide_on_requests
    all.where(:status => "PENDING").each { |request| request.overlapping_pending_requests }
  end

  def pending?
    status == "PENDING"
  end

end