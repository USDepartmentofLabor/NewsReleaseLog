require 'csv'

################ NOTICE #########################
#RUN SEED ONLY ONCE DURING SETTING UP THE PROJECT

csv_text = File.read(Rails.root.join('dump', 'news_release_agency.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Agency.new
  t.name = row['AgencyName']
  t.code = row["AgencyName"]
  t.frequently_used = row["FrequentlyUsed"]
  t.save
  puts "#{t.name}, #{t.code} saved"
end

puts "There are now #{Agency.count} rows in the table Agency"

csv_text = File.read(Rails.root.join('dump', 'news_release_region.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  r = Region.new
  r.name = row['RegionName']
  r.code = r.name[0..2].upcase
  r.save
  puts "#{r.name} saved"
end

puts "There are now #{Region.count} rows in the table Region"

csv_text = File.read(Rails.root.join('dump', 'news_release_media.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  d = Distributionlist.new
  d.description = row['Desc2']
  d.abbr=row['MediaAbbr']
  d.name=row['MediaDesc']
  d.status=row['Status']
  d.save
  puts "#{d.name} saved"
end

puts "There are now #{Distributionlist.count} rows in the table Distributionlist"

# Create Admin User
# Create Admin User
User.create(email: "nrladmin@dol.gov", password: "G*Yn7g<Ab-", password_confirmation: "G*Yn7g<Ab-" ,first_name: 'News', last_name: 'Release', role: :admin)

puts "There are now #{User.count} documents in the User collection"
