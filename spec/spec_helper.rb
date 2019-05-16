# frozen_string_literal: true

require 'saucer'

RSpec.configure do |config|
  config.before do
    ENV['BUILD_NAME'] ||= "Ruby-RSpec-Selenium: Local-#{Time.now.to_i}"

    options = Saucer::Options.new(platform)
    @session = Saucer::Session.begin(options)
    @driver = @session.driver
  end

  config.after do
    @session.end
  end

  #
  # Note that having this as a conditional in the test code is less ideal
  # It is better for static data to be pulled from a serialized file like a yaml
  #
  # Note: not all browsers are defaulting to using w3c protocol
  # This will change soon. Where possible prefer the w3c approach
  #
  def platform
    case ENV['PLATFORM']
    when 'windows_10_edge'
      {platform_name: 'Windows 10',
       browser_name: 'MicrosoftEdge',
       browser_version: '18.17763'}
    when 'windows_8_ie'
      {platform: 'Windows 8.1',
       browser_name: 'internet explorer',
       version: '11.0'}
    when 'mac_sierra_chrome'
      {platform_name: 'macOS 10.12',
       browser_name: 'chrome',
       "goog:chromeOptions": {w3c: true},
       browser_version: '74.0'}
    when 'mac_mojave_safari'
      {platform_name: 'macOS 10.14',
       browser_name: 'safari',
       browser_version: '12.0'}
    when 'windows_7_ff'
      {platform_name: 'Windows 7',
       browser_name: 'firefox',
       browser_version: '60.0'}
    else
      # Always specify a default;
      {platform_name: 'macOS 10.12',
       browser_name: 'chrome',
       "goog:chromeOptions": {w3c: true},
       browser_version: '74.0'}
    end
  end
end
