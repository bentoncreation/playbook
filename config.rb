activate :livereload
activate :directory_indexes
activate :settings

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
end

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.method = :rsync
  deploy.clean = true
  deploy.user = middleman_settings['deploy']['user']
  deploy.host = middleman_settings['deploy']['host']
  deploy.path = middleman_settings['deploy']['path']
  deploy.port = middleman_settings['deploy']['port']
end
