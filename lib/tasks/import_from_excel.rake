namespace :migration do
  desc "import legacy data from excel sheet"
  task import_from_excel: :environment do
    require 'spreadsheet'

    Spreadsheet.client_encoding = 'UTF-8'
    news_log_book = Spreadsheet.open(Rails.root.join('dump', 'document_test.xls'))
    news_log_sheet = news_log_book.worksheet 0
    
    header = []
    news_log_sheet.rows.each do |row|
      if header.empty?
        header = row.map(&:to_sym)
        next
      end

      row = Hash[header.zip(row)]
      puts row.inspect
      
      region = Region.where(:name => /^#{row[:RegionName].strip}$/i).first
      agency = Agency.where(:name => /^#{row[:AgencyName].strip}$/i).first
      if !region.present?
        file = File.open(Rails.root.join('lib', 'tasks', 'results', 'failures.txt'), 'a')
        file.puts "#{row[:OPAID]} failed because RegionName #{row[:RegionName]} not found"
        file.close
        next
      elsif !agency.present?
        file = File.open(Rails.root.join('lib', 'tasks', 'results', 'failures.txt'), 'a')
        file.puts "#{row[:OPAID]} failed because AgencyName #{row[:AgencyName]} not found"
        file.close
        next
      end

      puts "OPASeqnum2 #{row[:OPASeqnum2]}"
      d = NewsLog.new
      d.opa_id = row[:OPASeqnum1].to_i
      d.title = row[:Title].blank? ? "Title not given": row[:Title]
      d.received_date = row[:ReceivedDate]
      d.release_date = row[:ReleaseDate]
      d.news_release_number = row[:OPASeqnum2]
      document_path = Rails.root.join("public", "attachments", "#{row[:TitleFile]}")
      if File.exist?(document_path)
        d.document = File.open(Rails.root.join("public", "attachments", "#{row[:TitleFile]}"))
      end
      d.aasm_state ="published"
      d.agency = agency.id
      d.region = region.id
      d.imported_from_old_system = true
      d.user = User.first
      d.skip_callbacks =true
      if d.save
        puts "Successfully saved #{row[:OPAID]}"
        d.created_at = row[:OPANumIssueDate]
        d.save
      else
        file = File.open(Rails.root.join('lib', 'tasks', 'results', 'failures.txt'), 'a')
        file.puts "Unable to save #{d.opa_id} beacuse #{d.errors.full_messages}"
        file.close
      end
    end
  end
end
