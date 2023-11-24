require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  platforms :windows do
    gem "nokogiri", ">= 1.8.1", "!= 1.11.0"
  end
end

p "Ruby version: #{RUBY_VERSION}"
p "Ruby Platform: #{RUBY_PLATFORM}"
p "Bundler version: #{Bundler::VERSION}"
p "RubyGems version: #{Gem::VERSION}"

require 'nokogiri'
p "Nokogiri version: #{Nokogiri::VERSION}"