class NewsLog
  include Mongoid::Document
  include Mongoid::Timestamps
  include AASM
  # Fields
  field :received_date, type: Time
  field :release_date, type: Time
  field :title, type: String
  field :news_release_number, type: String

  # Associations
  belongs_to :user
  belongs_to :agency, optional: true
  belongs_to :region, optional: true
  has_and_belongs_to_many :distributionlists 

  # Validations
  validates_presence_of :title,:received_date
  # validates_length_of :news_release_number, minimum: 11

  # State machine
  aasm do
    state :draft, :initial => true
    state :review
    state :published
    state :archived

    event :review do
      transitions :from => :draft, :to => :review
    end

    event :publish  do
      transitions :from => :review, :to => :published
    end

    event :archive do
      transitions :from => [:draft, :published], :to => :archived
    end
  end

end
