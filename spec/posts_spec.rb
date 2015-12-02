urls = YAML.load_file('deploy/tests/urls.yaml')
RSpec.describe "Valid URLs from the Google Search Console", :type => :feature do
  urls.each_with_index do |url, index|
    it "#{url} should exist or redirect" do
      visit "http://127.0.0.1:4000/#{url}"
      expect(page).to have_css('.blog-posting')
    end
  end
end
