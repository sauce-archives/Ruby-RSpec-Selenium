def run_tests(platform, browser, version, junit_dir)
  system("platform=\"#{platform}\" browserName=\"#{browser}\" version=\"#{version}\" JUNIT_DIR=\"#{junit_dir}\" parallel_split_test spec")
end


task :windows_10_chrome_58_1 do
  run_tests('Windows 10', 'chrome', '58', 'junit_reports/windows_10_chrome_58')
end

task :windows_10_chrome_58_2 do
  run_tests('Windows 10', 'chrome', '58', 'junit_reports/windows_10_chrome_58')
end

task :windows_10_chrome_58_3 do
  run_tests('Windows 10', 'chrome', '58', 'junit_reports/windows_10_chrome_58')
end

task :windows_10_chrome_58_4 do
  run_tests('Windows 10', 'chrome', '58', 'junit_reports/windows_10_chrome_58')
end


multitask :test_sauce => [
    :windows_10_chrome_58_1,
    :windows_10_chrome_58_2,
    :windows_10_chrome_58_3,
    :windows_10_chrome_58_4
  ] do
    puts 'Running automation'
end

