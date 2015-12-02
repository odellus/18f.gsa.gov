urls = YAML.load_file('deploy/tests/urls.yaml')
RSpec.describe "individual blog post", :type => :feature do
  urls.each_with_index do |url, index|
    it "#{url} should exist and be properly formatted" do
      visit "http://127.0.0.1:4000/#{url}"
      expect(page).to have_css('.blog-posting')
    end
  end
end
