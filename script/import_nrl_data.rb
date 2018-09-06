require 'csv'

csv_text = File.open(Rails.root.join('dump', 'OPARelease_with_name.csv'),"r:ISO-8859-1")
csv = CSV.parse(csv_text, :headers => true)

csv.each do |row|
  region = Region.where(:name => /^#{row['RegionName'].strip}$/i).first
  agency = Agency.where(:name => /^#{row['AgencyName'].strip}$/i).first
  if !region.present?
    puts "Unable to find region .. RegionName #{row['RegionName']} Agnecy #{row['AgencyName']}" 
    puts "Skipping OPAID #{row['OPAID']}"
    next
  elsif !agency.present?
  	puts "Unable to find agency .. Agnraoecy #{row['AgencyName']}" 
  	puts "Skipping OPAID #{row['OPAID']}"
  	next
  end
  puts "OPASeqnum2 #{row['OPASeqnum2']}"
  d = NewsLog.new
  d.opa_id = row['OPAID']
  d.title = row["Title"]
  d.received_date = row["ReceivedDate"]
  d.release_date = row["ReleaseDate"]
  d.news_release_number = row["OPASeqnum2"]
  d.aasm_state ="published"
  d.agency = agency.id
  d.region = region.id
  d.user = User.first
  if d.save
  	puts "Successfully saved #{row['OPAID']}"
  else
    puts "Unable to save #{d.errors.full_messages}"
  end
end
