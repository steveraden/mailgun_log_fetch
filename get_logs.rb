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

def process_logs logs
  report = Array.new
  report << logs["items"].first.keys.join("|")
  logs["items"].each do |item|
    report << item.values.join("|")        
  end
  return report
end

domain = ARGV[0]
byebug
report = process_logs(get_logs(domain))
File.open("mailgun_report.txt", 'w') do |file|
  report.each do |line|
    file.puts(line)
  end  
end 


