require "watir"
require "watir_drops"
require "watir_model"
require "rspec"
require "sauce_whisk"

require_relative '../config/data/watir_model'
require_relative 'pages/guinea_pig_page'

RSpec.configure do |config|
  config.before(:each) do |test|
    capabilities = {name: test.full_description,
                    build: ENV['BUILD_TAG'] ||= "Unknown Build - #{Time.now.to_i}"}

    capabilities[:version] = ENV['version'] if ENV['version']
    capabilities[:browserName] = ENV['browserName'] if ENV['browserName']
    capabilities[:platform] = ENV['platform'] if ENV['platform']

    url = "https://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com:443/wd/hub".strip
    @browser = Watir::Browser.new :remote, {url: url,
                                            desired_capabilities: capabilities}
    WatirDrops::PageObject.browser = @browser

    if ENV['APPLITOOLS_ACCESS_KEY']
      require 'eyes_selenium'
      @eyes = Applitools::Eyes.new
      @eyes.api_key = ENV['APPLITOOLS_ACCESS_KEY']
    end
  end

  config.after(:each) do |example|
    if @eyes
      @eyes.test(app_name: 'Applitools',
                 test_name: test,
                 viewport_size: {width: 1008, height: 615},
                 driver: @browser.wd) do
        # Visual validation point #1
        @eyes.check_window('Main Page')
      end
    end

    session_id = @browser.wd.session_id
    SauceWhisk::Jobs.change_status(session_id, example.exception.nil?)
  end
end

