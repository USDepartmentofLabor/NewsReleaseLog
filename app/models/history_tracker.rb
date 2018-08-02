class HistoryTracker
  include Mongoid::History::Tracker

  def format_existing_track
    changes = {}
    if self.original.present?
      self.modified.keys.each do |key|
        case key
        when 'received_date'
          changes["Received Date"] = { changed: self.modified[key], original: self.original[key] }
        when 'release_date'
          changes["Release Date"] = { changed: self.modified[key], original: self.original[key] }
        when 'agency_id'
          changes["Agency"] = { changed: get_agency_name(self.modified[key]), original: get_agency_name(self.original[key]) }
        when 'region_id'
          changes["Region"] = { changed: get_region_name(self.modified[key]), original: get_region_name(self.original[key]) }
        when 'distributionlist_ids'
          changes["Distribution Lists"] = { changed: get_distribution_lists(self.modified[key]), original: get_distribution_lists(self.original[key]) }
        end
      end
      changes
    end
  end

  def format_new_track
    changes = {}
    self.modified.keys.each do |key|
      case key
      when 'received_date'
        changes["Received Date"] = { created: self.modified[key] }
      when 'release_date'
        changes["Release Date"] = { created: self.modified[key] }
      when 'agency_id'
        changes["Agency"] = { created: get_agency_name(self.modified[key]) }
      when 'region_id'
        changes["Region"] = { created: get_region_name(self.modified[key]) }
      when 'aasm_state'
        changes["State"] = { created: self.modified[key] }
      when 'distributionlist_ids'
        changes["Distribution Lists"] = { created: get_distribution_lists(self.modified[key]) }
      end
    end
    changes
  end


  def get_distribution_lists(ids)
    name_array = []
    ids.each do |id|
      name_array << Distributionlist.find(id).name
    end
    name_array.join(", ")
  end

  def get_agency_name(id)
    Agency.find(id).name
  end

  def get_region_name(id)
    Region.find(id).name
  end
end