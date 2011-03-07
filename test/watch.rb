def run_tests(test_type)
  case test_type
  when :all
    system('rake test')
  when /(controllers|functional)\/?/
    system('rake test:functionals')
  when /(models|unit)\/?/
    system('rake test:units')
  else
    # do nothing...
  end
end

[
  'app/(.*/)?.*\.rb',
  'test/(.*/)?.*\.rb'
].each { |pattern| watch(pattern) { |md| run_tests(md[1]) } }

# Ctrl-\
Signal.trap('QUIT') do
  puts "\n--- Running all tests ---\n"
  run_tests(:all)
end

# Ctrl-C
Signal.trap('INT') { abort("\n") }
