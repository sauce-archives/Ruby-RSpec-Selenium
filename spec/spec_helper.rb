require "selenium-webdriver"
require "rspec"
require "appium_lib"
require "sauce_whisk"

RSpec.configure do |config|
  config.before(:each) do |test|
    capabilities = {name: test.full_description,
                    build: ENV['BUILD_TAG'] || "Unknown Build - #{Time.now.to_i}"}

    capabilities[:version] = ENV['version'] if ENV['version']
    capabilities[:browserName] = ENV['browserName'] if ENV['browserName']
    capabilities[:platform] = ENV['platform'] if ENV['platform']
    capabilities[:deviceType] = ENV['deviceType'] if ENV['deviceType']
    capabilities[:platformVersion] = ENV['platformVersion'] if ENV['platformVersion']
    capabilities[:deviceName] = ENV['deviceName'] if ENV['deviceName']
    capabilities[:platformName] = ENV['platformName'] if ENV['platformName']
    capabilities[:app] = ENV['app'] if ENV['app']
    capabilities[:appiumVersion] = ENV['appiumVersion'] if ENV['appiumVersion']

    @mobile = capabilities.key? :app

    if @mobile
      @driver = Appium::Driver.new(caps: capabilities)
      @driver.start_driver
    else
      url = "https://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com:443/wd/hub".strip
      @driver = Selenium::WebDriver.for :remote, {url: url,
                                                  desired_capabilities: capabilities}
    end

    if ENV['APPLITOOLS_ACCESS_KEY']
      require 'eyes_selenium'
      @eyes = Applitools::Eyes.new
      @eyes.api_key = ENV['APPLITOOLS_ACCESS_KEY']
    end
  end


  config.after(:each) do |example|
    if @eyes
      @eyes.test(app_name: 'Applitools', test_name: test,
                 viewport_size: {width: 1008, height: 615}, driver: @driver) do
        # Visual validation point #1
        @eyes.check_window('Main Page')
      end
    end

    session_id = @driver.session_id
    SauceWhisk::Jobs.change_status(session_id, example.exception.nil?)
  end
end

