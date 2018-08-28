# def import_employer(in_file)
#     # config = YAML.load_file("#{Rails.root}/conversions.yml")
# #  begin
#     result_file = File.open(File.join(Rails.root, "csv_uploaded_file", "RESULT_" + File.basename(in_file) + ".csv"), 'wb')
#     importer = Importers::UsersDataSet.new(in_file, result_file)
#     importer.import!
#     result_file.close
# #  rescue
# #    raise in_file.inspect
# #  end
# end

# dir_glob = File.join(Rails.root, "csv_file_name","*.{xlsx,csv}")
# Dir.glob(dir_glob).sort.each do |file|
#   puts "PROCESSING: #{file}"
#   import_employer(file)
# end


csv_text = File.read(Rails.root.join('dump', '.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  d = NewsLog.new
  d.opa_id = row['OPAID']
  d.title = row["title"]
  d.received_date = row["ReceivedDate"]
  d.release_date = row["ReleaseDate"]
  d.news_release_number = row["OPASeqnum2"]
  d.aasm_state ="published"
  Region.find_by_code(row[''])
  d.region =row['RegionID']
  Agnecy.find_by_code(row[''])
  d.name=row['AgencyID']
  d.save
end
