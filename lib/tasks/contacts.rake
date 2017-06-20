require 'spreadsheet'
#The rake task to upload the bank excel file into the branch table
namespace :import do
  desc "Import Contacts from Excel"
  task contacts: :environment do
    filename = File.join Rails.root.join('docs'), "Membership_SustainingPartner_2016-10-03.xls"
    puts "Currently reading #{filename}."
    excel = Spreadsheet.open filename
    sheet = excel.worksheet 0
    num_rows = 0
    sheet.each do |contact|
      num_rows += 1
      value = { first_name: contact[0], last_name: contact[1], email_address: contact[2], organization: contact[3], title: contact[4],
        phone_number: contact[5], address_1: contact[6], address_2: contact[7], city: contact[8], state: contact[9], zip: contact[10],
        business_size: contact[11], amount_paid: contact[12] }
      Contact.create!(value)
    end
    puts "Read #{num_rows} rows"
    
    
    filename2 = File.join Rails.root.join('docs'), "Membership_FY2017GovtMembers_2016-10.xls"
    puts "Currently reading #{filename2}."
    excel2 = Spreadsheet.open filename2
    sheet2 = excel2.worksheet 0
    num_rows2 = 0
    sheet2.each do |contact2|
      num_rows2 += 1
      value2 = { first_name: contact2[0], last_name: contact2[1], email_address: contact2[2], organization: contact2[3],
        member: true, affiliation_id: contact2[5].to_i, comments: contact2[6] }
      Contact.create!(value2)
      puts value2
    end
    puts "Read #{num_rows2} rows"
    
    
    filename3 = File.join Rails.root.join('docs'), "Expired-RenewalTracking.xls"
    puts "Currently reading #{filename3}."
    excel3 = Spreadsheet.open filename3
    sheet3 = excel3.worksheet 0
    num_rows3 = 0
    sheet3.each do |contact3|
      num_rows3 += 1
      value3 = { first_name: contact3[0], last_name: contact3[1], email_address: contact3[2], organization: contact3[3], title: contact3[4],
        phone_number: contact3[5], address_1: contact3[6], address_2: contact3[7], city: contact3[8], state: contact3[9], zip: contact3[10],
        business_size: contact3[11], amount_owed: contact3[12], date_last_paid: contact3[13], comments: contact3[14] }
      Contact.create!(value3)
    end
    puts "Read #{num_rows3} rows"
  end
end
