require 'csv'
require 'safe_yaml'
data = CSV.read('deploy/tests/errors.csv')
location = data[0].index("URL")
code = data[0].index("Response Code")
urls ||= []
data.each_with_index do |entry, index|
  url = entry[location].sub("https://18f.gsa.gov", "http://localhost:4000")
  if url.match("hub")
    next
  elsif entry[code] == "404"
    urls.push(url)
  end
end
File.open('deploy/tests/errors.yaml', 'w') { |f|
  f.write YAML.dump(urls)
}
