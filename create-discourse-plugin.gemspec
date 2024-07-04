Gem::Specification.new do |s|
  s.name        = 'create-discourse-plugin'
  s.required_ruby_version = '>= 2.7.0'
  s.version     = '0.2.0'
  s.licenses    = ['MIT']
  s.summary     = 'Create a Discourse plugin from a template.'
  s.description = 'Based on the Discourse plugin skeleton, this script creates a new plugin with the provided name.'
  s.authors     = ['Gabriel Grubba']
  s.email       = 'grubba27@hotmail.com'
  s.files       = ['lib/create-discourse-plugin.rb']
  s.executables << 'create-discourse-plugin'
end
