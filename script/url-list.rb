require 'safe_yaml'

SafeYAML::OPTIONS[:default_mode] = :safe
posts = Dir.glob('_posts/*.md')
posts.delete_if { |post| post == "_posts/README.md" }
urls ||= []
posts.each_with_index do |post, index|
  frontmatter = YAML.load_file(post)
  if frontmatter['published'] == false
    next
  end
  unless frontmatter['permalink']
    # build a permalink if we're not given one
    filename = post.split(/[\/,\-,.]/) # break the filename into an array
    unless frontmatter['date']
      date = "#{filename[1]}/#{filename[2]}/#{filename[3]}"
    else
      date = frontmatter['date'].to_s.gsub('-', '/').split(' ')[0]
    end
    parts = filename.drop(4)
    parts.pop
    slug = parts.join('-').downcase
    url = "#{date}/#{slug}/"
  else
    url = frontmatter['permalink']
  end
  urls.push url
end
File.open('deploy/tests/urls.yaml', mode="w") {|f| f.write YAML::dump(urls) }
