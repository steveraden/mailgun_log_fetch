require 'rest_client'
require 'byebug'
require 'json'

def get_logs(domain)
  key = ENV["MAILGUN_KEY"]  
  response = RestClient.get "https://api:#{key}"\
  "@api.mailgun.net/v3/#{domain}/log", :params => {    
    :limit => 200
  }
  JSON.parse(response)  
end

def process_logs(logs)
  report = Array.new
  report << logs["items"].first.keys.join("|")
  logs["items"].each do |item|
    report << item.values.join("|")        
  end
  return report
end

def log_reader 
  final_report = Array.new
  File.open("mailgun_report.txt", 'r') do |file|   
    file.each_line.with_index do | line, i|
      if not i == 0
        final_report << process_line(line)
      end
    end
  end 
  final_report
end 

def process_line(line)
  fields = line.split("|")
  status = fields[0]
  message_details = fields[1]
  #gets rid of the first subfield which is redundant to fields[0] and white space
  message_details =  message_details.gsub(/^[[:alpha:]]*:/, "").strip  
  sub_fields = message_details.split("'")
  # get the people
  sender, recipient  =  sub_fields[0].split('→')
  # get the group and title
  title_subfields=  sub_fields[1].gsub(/^Re:/, "")
  group_regx =  /\[.*\]/  
  group = title_subfields[ group_regx ]
  title = title_subfields.gsub(group_regx, "")
  log_level = fields[2]
  date =  fields[3]
  guid = fields[4] 
  final_report_line = "#{status}\t#{title}\t#{group}\t#{sender}\t#{recipient}}\t#{date}\t#{log_level}\t#{guid}"
  final_report_line
end

# ## main
# domain = ARGV[0]
# report = process_logs(get_logs(domain))
# File.open("mailgun_report.txt", 'w') do |file|
#   report.each do |line|
#     file.puts(line)
#   end  
# end 

File.open("mailgun_report_final.txt", 'w') do |file|
  log_reader().each do |line|
    file.puts(line)
  end  
end 




# File.open('mailgun_report_final2.txt', 'w') do |outfile|
#   File.open('mailgun_report_final.txt', 'r') do |infile|
#     infile.each_line.with_index do |line, i|       
#       outfile.puts(line.gsub! /^$\n/, '')     
#     end
#   end
# end
