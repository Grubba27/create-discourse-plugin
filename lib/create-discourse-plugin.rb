# Helper
class Helpers
  def self.to_snake_case(string)
    string.dup.gsub!('-', '_')
  end

  def self.to_pascal_case(string)
    string.dup.split('-').map(&:capitalize).join
  end

  def self.to_pascal_spaced_case(string)
    string.dup.split('-').map(&:capitalize).join(' ')
  end
end

plugin_name = ARGV[0]

if plugin_name.nil?
  puts 'Please provide a plugin name, use kebab-case.'
  plugin_name = gets.chomp
end

system "gh repo create #{plugin_name} --template discourse/discourse-plugin-skeleton --private --clone"

puts '🚂 Renaming directories...'

File.rename "./#{plugin_name}/lib/my_plugin_module", "./#{plugin_name}/lib/#{Helpers.to_snake_case(plugin_name)}"

File.rename "./#{plugin_name}/app/controllers/my_plugin_module", "./#{plugin_name}/app/controllers/#{Helpers.to_snake_case(plugin_name)}"

to_update_files = # assume all start with ./#{plugin_name}/
  [
    "app/controllers/#{Helpers.to_snake_case(plugin_name)}/examples_controller.rb",
    'config/locales/client.en.yml',
    'config/routes.rb',
    'config/settings.yml',
    "lib/#{Helpers.to_snake_case(plugin_name)}/engine.rb",
    'plugin.rb',
    'README.md'
  ]

to_update_files.each do |file|
  puts "🚂 Updating #{file}..."

  updated_file = ''
  File.foreach("./#{plugin_name}/#{file}") do |line|
    updated_file << line.gsub('MyPluginModule', Helpers.to_pascal_case(plugin_name))
                        .gsub('my_plugin_module', Helpers.to_snake_case(plugin_name))
                        .gsub('my-plugin', plugin_name)
                        .gsub('discourse-plugin-name', plugin_name)
                        .gsub('TODO_plugin_name', Helpers.to_snake_case(plugin_name))
                        .gsub('plugin_name_enabled', "#{Helpers.to_snake_case(plugin_name)}_enabled")
                        .gsub('discourse_plugin_name', Helpers.to_snake_case(plugin_name))
                        .gsub('Plugin Name', Helpers.to_pascal_spaced_case(plugin_name))
                        .gsub('lib/my_plugin_module/engine', "lib/#{Helpers.to_snake_case(plugin_name)}/engine")
  end

  File.open("./#{plugin_name}/#{file}", 'w') { |f| f.write(updated_file) }
end

puts 'Done! 🎉'

puts 'Do not forget to update the README.md and plugin.rb file with the plugin description and the url of the plugin.'
puts 'You are ready to start developing your plugin! 🚀'
