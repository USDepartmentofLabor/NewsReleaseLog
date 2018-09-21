require 'csv'

header = []
File.foreach(Rails.root.join('dump', 'temp.csv')) do |csv_line|
  row = CSV.parse(csv_line.scrub.gsub(/'|\"/,''),:encoding => 'ISO-8859-1:utf-8').first
  byebug
  if header.empty?
    header = row.map(&:to_sym)
    next
  end
  row = Hash[header.zip(row)]
  region = Region.where(:name => /^#{row[:RegionName].strip}$/i).first
  agency = Agency.where(:name => /^#{row[:AgencyName].strip}$/i).first
  if !region.present?
    puts "Unable to find region .. RegionName #{row[:RegionName]} Agnecy #{row[:AgencyName]}"
    puts "Skipping OPAID #{row[:OPAID]}"
    next
  elsif !agency.present?
  	puts "Unable to find agency .. Agnraoecy #{row[:AgencyName]}"
  	puts "Skipping OPAID #{row[:OPAID]}"
  	next
  end
  puts "OPASeqnum2 #{row[:OPASeqnum2]}"
  d = NewsLog.new
  d.opa_id = row[:OPASeqnum1]
  d.title = row[:Title]
  d.received_date = row[:ReceivedDate]
  d.release_date = row[:ReleaseDate]
  d.news_release_number = row[:OPASeqnum2]
  d.aasm_state ="published"
  d.agency = agency.id
  d.region = region.id
  d.imported_from_old_system = true
  d.user = User.first
  d.skip_callbacks =true
  if d.save
  	puts "Successfully saved #{row[:OPAID]}"
  else
    puts "Unable to save #{d.errors.full_messages}"
  end
end
