urls = YAML.load_file('deploy/tests/errors.yaml')
RSpec.describe "individual blog post", :type => :feature do
  urls.each_with_index do |url, index|
    it "#{url} should exist and be properly formatted" do
      visit url
      expect(page).to have_css('.usa')
    end
  end
end
