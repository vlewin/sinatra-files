require 'rest_client'

file = ARGV[0]

if ARGV[0] && File.file?(ARGV[0])
  client = RestClient::Resource.new('http://localhost:9292/files/upload', :user => 'foo', :password => 'bar')
  client.post(file: File.new(ARGV[0]))
else
  puts "No such file '#{ARGV[0]}'"
end
