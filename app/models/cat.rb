class Cat < ActiveRecord::Base
  attr_accessible :name, :age, :sex, :birth_date, :color, :colors

  has_many :cat_rental_requests, :dependent => :destroy

	belongs_to(
	:owner,
	:class_name => "User",
	:foreign_key => :user_id
	)

  def self.colors
    @colors = %w(Tabby White Black Ginger Ugly Grey)
  end

  validates :sex, inclusion: { in: %w(M F) } #, message "Not a valid sex" }
  validates :color, inclusion: { in: colors }#, message "It is impossible for a cat to be colored that!"}
  validates :name, :age, :sex, :birth_date, :color, :presence => true


end