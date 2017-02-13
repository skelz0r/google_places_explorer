require 'google_places'

client = GooglePlaces::Client.new(ENV['TOKEN'])

YAML.load(File.read('./tests.yml'))['tests'].each do |test|
  print "===================================\n"
  print "= #{test['name']} =\n"
  print "===================================\n"

  if test['kind'] == 'query'
    results = client.spots_by_query(test['query'],test['options'])
  else
    results = client.spots(test['latitude'], test['longitude'], test['options'])
  end

  print "RESULTS COUNT: #{results.count}"

  results.each do |result|
    print "------------------\n"
    [
      :name,
      :types,
      :formatted_address,
      :lat,
      :lng,
    ].each do |attr|
      print "#{attr}: #{result.public_send(attr)}\n"
    end
    print "https://maps.google.com/?q=#{result.lat},#{result.lng}\n"
    print "------------------\n"
  end

  print "===================================\n\n\n\n"
end
