class NewsLog
  include Mongoid::Document
  include Mongoid::Timestamps
  include AASM
  include Mongoid::History::Trackable

  # Fields
  field :received_date, type: Date
  field :release_date, type: Date
  field :title, type: String
  field :news_release_number, type: String
  field :aasm_state
  field :opa_id,  type: Integer
  mount_uploader :document, DokumentUploader

  index({ news_release_number: 'text' })
  index({ title: 'text' })
  index({ news_release_number: 1 , title: 1 })

  # Associations
  belongs_to :user
  belongs_to :agency, optional: true
  belongs_to :region, optional: true
  has_and_belongs_to_many :distributionlists

  track_history   :on => :all,
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
  validates_presence_of :title, :region, :received_date
  validates_uniqueness_of :news_release_number

  before_save :assign_nrl_number

  STATES = %w{ draft review published archived }

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

  def self.filter(attributes)
    attributes.select { |k, v| v.present? }.reduce(all) do |scope, (key, value)|
      case key.to_sym
      when :aasm_state
        scope.where(key => value)
      when :news_release_number,:title # regexp search
        scope.where({key => { :$regex => /#{value}/i }})
      when :received_date
        scope.between(:received_date => (value[:start_date]..value[:end_date]))
      when :agency
        agency = Agency.where(:code => value).first
        scope.where(:agency_id => agency.id) if agency
      when :region
        region = Region.where(:name => value).first
        scope.where(:region_id => region.id) if region
      when :order_by
        scope.order_by(:created_at => value)
      else
        scope
      end
    end
  end

  def self.search(q)
    NewsLog.where('$or' => [ { news_release_number: { :$regex => /#{q}/i } }, { title: { :$regex => /#{q}/i } } ])
  end

  def self.advanced_search(keyword, agency_id, region_id)
    NewsLog.where(agency_id: agency_id).where(region_id: region_id).where('$or' => [ { news_release_number: { :$regex => /#{keyword}/i } }, { title: { :$regex => /#{keyword}/i } } ])
  end

  private
  def assign_nrl_number
    return unless self.new_record?
    max_opa_id = NewsLog.where(:created_at.gte => Time.now.beginning_of_year ,:created_at.lte => Time.now.end_of_year).max(:opa_id)
    max_opa_id.present? ? self.opa_id = max_opa_id + 1 : self.opa_id = 1
    self.news_release_number = "#{Date.current.strftime("%y")}-#{self.opa_id.to_s.rjust(4, '0')}-#{region.code}"
  end
end
