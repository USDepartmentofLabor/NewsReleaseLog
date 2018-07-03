class NewsLog
  include Mongoid::Document
  include Mongoid::Timestamps
  include AASM
  include Mongoid::History::Trackable

  # Fields
  field :received_date, type: Time
  field :release_date, type: Time
  field :title, type: String
  field :news_release_number, type: String
  field :aasm_state

  # Associations
  belongs_to :user
  belongs_to :agency, optional: true
  belongs_to :region, optional: true
  has_and_belongs_to_many :distributionlists

  track_history   :on => [:title, :received_date, :release_date, :aasm_state],
                  :modifier_field => :modifier,
                  :modifier_field_inverse_of => :nil,
                  :modifier_field_optional => true,
                  :version_field => :version,
                  :track_create  => true,
                  :track_update  => true,
                  :track_destroy => true

  scope :published, -> { where(aasm_state: 'published') }
  scope :drafts, -> { where(aasm_state: 'draft') }
  scope :active_drafts, -> { where(aasm_state: 'draft',:created_at.gt => 2.weeks.ago) }


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
