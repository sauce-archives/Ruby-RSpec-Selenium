require 'rspec/core/rake_task'

task default: :test_all

# %w[desktop android ios].each do |type|
#   RSpec::Core::RakeTask.new(type) do |spec|
#     puts type
#     spec.pattern = "spec/#{type}/*_spec.rb"
#   end
# end

task :parallel_run do
  begin
    @success = true if @success.nil?
    @result = system "parallel_split_test spec/#{ENV['SPEC_TYPE']}"
  ensure
    @success &= @result
  end
end

task :windows_10_edge_14 do
  ENV['SPEC_TYPE'] = 'desktop'
  ENV['platform'] = 'Windows 10'
  ENV['browserName'] = 'MicrosoftEdge'
  ENV['version'] = '14.14393'
  ENV['JUNIT_DIR'] = 'junit_reports/windows_10_edge_14'

  Rake::Task[:parallel_run].execute
end

task :windows_10_firefox_49 do
  ENV['SPEC_TYPE'] = 'desktop'
  ENV['platform'] = 'Windows 10'
  ENV['browserName'] = 'firefox'
  ENV['version'] = '49.0'
  ENV['JUNIT_DIR'] = 'junit_reports/windows_10_firefox_49'

  Rake::Task[:parallel_run].execute
end

task :windows_7_ie_11 do
  ENV['SPEC_TYPE'] = 'desktop'
  ENV['platform'] = 'Windows 7'
  ENV['browserName'] = 'internet Explorer'
  ENV['version'] = '11.0'
  ENV['JUNIT_DIR'] = 'junit_reports/windows_7_ie_11'

  Rake::Task[:parallel_run].execute
end

task :os_x_10_11_safari_10 do
  ENV['SPEC_TYPE'] = 'desktop'
  ENV['platform'] = 'OS X 10.11'
  ENV['browserName'] = 'safari'
  ENV['version'] = '10.0'
  ENV['JUNIT_DIR'] = 'junit_reports/os_x_10_11_safari_10'

  Rake::Task[:parallel_run].execute
end

task :os_x_10_10_chrome_54 do
  ENV['SPEC_TYPE'] = 'desktop'
  ENV['platform'] = 'OS X 10.10'
  ENV['browserName'] = 'chrome'
  ENV['version'] = '54.0'
  ENV['JUNIT_DIR'] = 'junit_reports/os_x_10_10_chrome_54'

  Rake::Task[:parallel_run].execute
end

task :iPad_Air_2_Simulator do
  ENV['SPEC_TYPE'] = 'ios'
  ENV['app'] = 'https://github.com/saucelabs-sample-test-frameworks/GuineaPig-Sample-App/blob/master/iOS/simulator/SauceGuineaPig-sim-debug.app.zip?raw=true'
  ENV['deviceName'] = 'iPad Air 2 Simulator'
  ENV['platformVersion'] = '9.3'
  ENV['appiumVersion'] = '1.6.3'
  ENV['platformName'] = 'ios'
  ENV['deviceOrientation'] = 'portrait'
  ENV['browserName'] = ''

  Rake::Task[:parallel_run].execute
end

task :iPhone_7_Simulator do
  ENV['SPEC_TYPE'] = 'ios'
  ENV['app'] = 'https://github.com/saucelabs-sample-test-frameworks/GuineaPig-Sample-App/blob/master/iOS/simulator/SauceGuineaPig-sim-debug.app.zip?raw=true'
  ENV['deviceName'] = 'iPhone 7 Simulator'
  ENV['platformVersion'] = '10.0'
  ENV['appiumVersion'] = '1.6.3'
  ENV['platformName'] = 'ios'
  ENV['deviceOrientation'] = 'portrait'
  ENV['browserName'] = ''

  Rake::Task[:parallel_run].execute
end

task :iPhone_6_Device do
  ENV['SPEC_TYPE'] = 'ios'
  caps['deviceName'] = 'iPhone 6s Device'
  caps['platformVersion'] = '9.3'
  caps['appiumVersion'] = '1.5.3'
  ENV['platformName'] = 'ios'
  ENV['deviceOrientation'] = 'portrait'
  ENV['browserName'] = ''

  Rake::Task[:parallel_run].execute
end

task :test_android_emulator_5 do
  ENV['SPEC_TYPE'] = 'android'
  ENV['appiumVersion'] = '1.5.3'
  ENV['deviceOrientation'] = 'portrait'
  ENV['platformName'] = 'Android'
  ENV['app'] = 'https://github.com/saucelabs-sample-test-frameworks/GuineaPig-Sample-App/blob/master/android/GuineaPigApp-debug.apk?raw=true'
  ENV['deviceName'] = 'Android Emulator'
  ENV['platformVersion'] = '5.1'
  ENV['browserName'] = ''

  Rake::Task[:parallel_run].execute
end

task :test_android_s4_4_4 do
  ENV['SPEC_TYPE'] = 'android'
  ENV['appiumVersion'] = '1.5.3'
  ENV['deviceOrientation'] = 'portrait'
  ENV['platformName'] = 'Android'
  ENV['app'] = 'https://github.com/saucelabs-sample-test-frameworks/GuineaPig-Sample-App/blob/master/android/GuineaPigApp-debug.apk?raw=true'
  ENV['deviceName'] = 'Samsung Galaxy S4 Emulator'
  ENV['platformVersion'] = '4.4'
  ENV['browserName'] = ''

  Rake::Task[:parallel_run].execute
end

task :test_android_device_s6 do
  ENV['SPEC_TYPE'] = 'android'
  ENV['appiumVersion'] = '1.5.3'
  ENV['deviceOrientation'] = 'portrait'
  ENV['platformName'] = 'Android'
  ENV['app'] = 'https://github.com/saucelabs-sample-test-frameworks/GuineaPig-Sample-App/blob/master/android/GuineaPigApp-debug.apk?raw=true'
  ENV['deviceName'] = 'Samsung Galaxy S6 Device'
  ENV['deviceName'] = 'Samsung Galaxy'
  ENV['platformVersion'] = '6.0'
  ENV['browserName'] = ''

  Rake::Task[:parallel_run].execute
end

multitask :test_desktop => [
    :windows_10_edge_14,
    :windows_10_firefox_49,
    :windows_7_ie_11,
    :os_x_10_11_safari_10,
    :os_x_10_10_chrome_54
] do
  raise StandardError, "Tests failed!" unless @success
end

multitask :test_ios => [
    :iPad_Air_2_Simulator,
    # Real Device Not Implemented
    #:iPhone_6_Device,
    :iPhone_7_Simulator
] do
  raise StandardError, "Tests failed!" unless @success
end

multitask :test_android => [
    :test_android_emulator_5,
    # Real Device Not Implemented
    #:test_android_device_s6,
    :test_android_s4_4_4
] do
  raise StandardError, "Tests failed!" unless @success
end

multitask :test_all => [
    :windows_10_edge_14,
    :windows_10_firefox_49,
    :windows_7_ie_11,
    :os_x_10_11_safari_10,
    :os_x_10_10_chrome_54,
    :iPad_Air_2_Simulator,
    :iPhone_7_Simulator,
    :test_android_emulator_5,
    :test_android_s4_4_4
] do
  raise StandardError, "Tests failed!" unless @success
end

