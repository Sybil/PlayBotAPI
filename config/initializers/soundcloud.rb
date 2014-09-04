#require 'yaml'

soundcloud = YAML.load_file("#{File.dirname(__FILE__)}/../soundcloud.yml")
$soundcloud = Soundcloud.new(:client_id => soundcloud["client_id"])
