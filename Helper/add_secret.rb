require 'json'

puts 'Helper Secret Adder'

file_name = 'Config.xcconfig'
helper_prefix = 'HELPER_CONFIG = '

if !File.exists? file_name
  puts 'Creating Config File'
  File.new file_name, 'w'
end

file = File.open file_name
file_lines = file.readlines.map(&:chomp)
file.close

config_line = file_lines.find do |line|
  line.start_with? helper_prefix
end

json_string = ''
config_data = Hash.new
secrets = Hash.new

if config_line
  puts 'Updating Helper Config Data:'
  json_string = config_line.delete_prefix(helper_prefix)
  puts json_string
  config_data = JSON.parse(json_string)
  secrets_from_config = config_data['HELPER_SECRETS']
  if secrets_from_config
    secrets = secrets_from_config
  else
    config_data['HELPER_SECRETS'] = secrets
  end
else
  puts 'Creating Helper Config'
  config_data['HELPER_SECRETS'] = secrets
end

loop do
  puts 'Key: '
  key = gets.chomp
  break if key == ''

  puts 'Value: '
  value = gets.chomp

  secrets[key] = value
end

json_string = config_data.to_json
new_config_line = helper_prefix + json_string

puts new_config_line

File.write file_name, new_config_line
