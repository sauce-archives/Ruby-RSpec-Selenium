require 'rspec'
require 'capybara'
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'site_prism'
require 'sauce_whisk'

require_relative '../../lib/pages/guinea_pig_page'

Before do |scenario|
  Capybara.register_driver :sauce do |app|
    capabilities = {name: "#{scenario.feature.name} - #{scenario.name}",
                    build: ENV['BUILD_TAG'] ||= "Unknown Build - #{Time.now.to_i}"}

    capabilities[:version] = ENV['version'] if ENV['version']
    capabilities[:browserName] = ENV['browserName'] if ENV['browserName']
    capabilities[:platform] = ENV['platform'] if ENV['platform']

    url = "https://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com:443/wd/hub".strip

    Capybara::Selenium::Driver.new(app, {browser: :remote,
                                         url: url,
                                         desired_capabilities: capabilities})
  end
  Capybara.current_driver = :sauce

  if ENV['APPLITOOLS_ACCESS_KEY']
    require 'eyes_selenium'
    @eyes = Applitools::Eyes.new
    @eyes.api_key = ENV['APPLITOOLS_ACCESS_KEY']
  end
end

After do |scenario|
  driver = ::Capybara.current_session.driver

  if @eyes
    @eyes.test(app_name: 'Applitools',
               test_name: @name,
               viewport_size: {width: 1008, height: 615},
               driver: driver) do
      # Visual validation point #1
      @eyes.check_window('Main Page')
    end
  end

  SauceWhisk::Jobs.change_status(driver.browser.session_id, scenario.passed?)
  driver.quit
end
