require 'rspec'
require 'watir'
require 'sauce_whisk'
require 'page-object'

require 'data_magic'
DataMagic.load 'data_magic.yml'

require 'page-object/page_factory'
World(PageObject::PageFactory)

require_relative '../support/pages/guinea_pig_page'

Before do |scenario|
  @name = "#{scenario.feature.name} - #{scenario.name}"
  capabilities = {name: @name,
                  build: ENV['BUILD_TAG'] ||= "Unknown Build - #{Time.now.to_i}"}

  capabilities[:version] = ENV['version'] if ENV['version']
  capabilities[:browserName] = ENV['browserName'] if ENV['browserName']
  capabilities[:platform] = ENV['platform'] if ENV['platform']
  url = "https://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com:443/wd/hub".strip

  @browser = Watir::Browser.new :remote, {url: url,
                                          desired_capabilities: capabilities}

  if ENV['APPLITOOLS_ACCESS_KEY']
    require 'eyes_selenium'
    @eyes = Applitools::Eyes.new
    @eyes.api_key = ENV['APPLITOOLS_ACCESS_KEY']
  end
end

After do |scenario|
  if @eyes
    @eyes.test(app_name: 'Applitools',
               test_name: @name,
               viewport_size: {width: 1008, height: 615},
               driver: @browser.wd) do
      # Visual validation point #1
      @eyes.check_window('Main Page')
    end
  end

  session_id = @browser.wd.session_id
  SauceWhisk::Jobs.change_status(session_id, scenario.passed?)
end
