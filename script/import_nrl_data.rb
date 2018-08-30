require 'csv'

csv_text = File.read(Rails.root.join('dump', 'OPARelease_with_name.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  region = Region.find_by_name(row['RegionName'])
  agency = Agnecy.find_by_name(row['AgencyName'])
  unless region || agency
  	puts "Unable to find region or agency .. RegionName #{row[RegionName]} Agnecy #{row[AgencyName]}" 
  	puts "Skipping OPAID #{row['OPAID']}"
  	next
  end
  d = NewsLog.new
  d.opa_id = row['OPAID']
  d.title = row["title"]
  d.received_date = row["ReceivedDate"]
  d.release_date = row["ReleaseDate"]
  d.news_release_number = row["OPASeqnum2"]
  d.aasm_state ="published"
  d.agency = agency
  d.region = region
  if d.save
  	puts "Successfully saved #{row['OPAID']}"
  end
end
