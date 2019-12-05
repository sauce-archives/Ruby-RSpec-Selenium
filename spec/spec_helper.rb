# frozen_string_literal: true

require 'selenium-webdriver'
require 'simple_sauce'


RSpec.configure do |config|
  config.before do |example|
    create_session(example.full_description)
  end

  config.after do |example|
    end_session(!example.exception)
  end

  def create_session(test_name)
    opts = platform.merge(name: test_name,
                          screen_resolution: '1080x720',
                          command_timeout: 90)
    sauce_options = SimpleSauce::Options.new(opts)

    @session = SimpleSauce::Session.new(sauce_options)
    @session.data_center = ENV['SAUCE_DATA_CENTER'].to_sym if ENV['SAUCE_DATA_CENTER']
    @driver = @session.start
  end

  def end_session(result)
    @session.stop(result)
  end

  # Ideal implementation is to do a lookup from a YAML file or the like rather than using a switch implementation
  def platform
    ENV['PLATFORM'] ||= 'mac_sierra_chrome'

    case ENV['PLATFORM']
    when 'windows_10_edge'
      {platform_name: 'Windows 10',
       browser_name: 'edge',
       browser_version: '18.17763'}
    when 'windows_8_ie'
      {platform: 'Windows 8.1',
       browser_name: 'ie',
       version: '11.0'}
    when 'mac_sierra_chrome'
      {platform_name: 'macOS 10.12',
       browser_name: 'chrome',
       browser_version: '75.0'}
    when 'mac_mojave_safari'
      {platform_name: 'macOS 10.14',
       browser_name: 'safari',
       browser_version: '12.0'}
    when 'windows_7_ff'
      {platform_name: 'Windows 7',
       browser_name: 'firefox',
       browser_version: '60.0'}
    when 'headless'
      ENV['SAUCE_DATA_CENTER'] = 'US_EAST'
      {platform_name: 'Linux',
       browser_name: 'chrome'}
    end
  end
end
