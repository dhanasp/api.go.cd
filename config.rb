require_relative "lib/version"
require_relative "lib/helpers"
helpers RenderAllSubTopics
helpers DescribeObjectHelper
helpers AvailableSinceHelper

# Markdown
set :markdown_engine, :redcarpet
set :markdown,
    fenced_code_blocks: true,
    smartypants: true,
    disable_indented_code_blocks: true,
    prettify: true,
    tables: true,
    with_toc_data: true,
    no_intra_emphasis: true

# Assets
set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :fonts_dir, 'fonts'

# Activate the syntax highlighter
activate :syntax

# Activate the sprocket pipeline
activate :sprockets

# Livereload in dev mode
activate :livereload
activate :autoprefixer do |config|
  config.browsers = ['last 2 version', 'Firefox ESR']
  config.cascade  = false
  config.inline   = true
end

# Github pages require relative links
activate :relative_assets
set :relative_links, true

activate :s3_sync do |s3_sync|
  s3_sync.bucket       = ENV['S3_BUCKET']
  s3_sync.region       = 'us-east-1'
  s3_sync.prefer_gzip  = false
  s3_sync.delete       = false
  s3_sync.prefix       = GOCD_VERSION
end

# Build Configuration
configure :build do
  set :build_dir, "build/#{GOCD_VERSION}"

  activate :minify_css
  activate :minify_javascript
  # activate :relative_assets
  # activate :asset_hash
  # activate :gzip
end
