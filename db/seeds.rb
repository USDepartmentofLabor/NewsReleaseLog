require 'spreadsheet'
require 'csv'

################ NOTICE #########################
#RUN SEED ONLY ONCE DURING SETTING UP THE PROJECT

# Importing agencies from news-release-agency.xls
Spreadsheet.client_encoding = 'UTF-8'
agency_book = Spreadsheet.open(Rails.root.join('dump', 'news-release-agency.xls'))
agency_sheet = agency_book.worksheet 0

header = []
agency_sheet.rows.each do |row|
  if header.empty?
    header = row.map(&:to_sym)
    next
  end
  row = Hash[header.zip(row)]

  t = Agency.new
  t.name = row[:AgencyName]
  t.code = row[:AgencyName]
  t.frequently_used = row["FrequentlyUsed"]
  t.save
  puts "#{t.name}, #{t.code} saved"
end

puts "Imported total #{Agency.count} agencies into DB"

# Importing regions from news-release-region.xls
region_book = Spreadsheet.open(Rails.root.join('dump', 'news-release-region.xls'))
region_sheet = region_book.worksheet 0

header = []
region_sheet.rows.each do |row|
  if header.empty?
    header = row.map(&:to_sym)
    next
  end
  row = Hash[header.zip(row)]

  r = Region.new
  r.name = row[:RegionName]
  r.code = r.name[0..2].upcase
  r.save
  puts "#{r.name} saved"
end

puts "Imported total #{Region.count} regions into DB"

# Importing distribution lists from news-release-distrib.xls
distribution_book = Spreadsheet.open(Rails.root.join('dump', 'news-release-distrib.xls'))
distribution_sheet = distribution_book.worksheet 0

header = []
distribution_sheet.rows.each do |row|
  if header.empty?
    header = row.map(&:to_sym)
    next
  end

  row = Hash[header.zip(row)]

  d = Distributionlist.new
  d.description = row[:Desc2]
  d.abbr = row[:MediaAbbr]
  d.name = row[:MediaDesc]
  d.status = row[:Status]
  if d.save
    puts "#{d.name} saved"
  else
    puts "#{d.name} not saved because #{d.errors.full_messages}"
  end
end

puts "Imported total  #{Distributionlist.count} rows in the DB"

# Uncomment the below line to create a initial user in server
# Replace email, password and password confirmation with the required fields
# Create Admin User
# User.create(email: <enter-admin-email-here>, password: <passwordhere>, password_confirmation: <passwordhere> ,first_name: 'News Release', last_name: 'Admin', role: :admin)
# 
# puts "There are now #{User.count} documents in the User collection"
