system 'clear'

# ------------------------------------------------------------------
# Signals

Signal.trap( 'QUIT' ) { run_all_tests }
Signal.trap( 'INT' )  { abort( "\n" ) }

# ------------------------------------------------------------------
# Watch Patterns

watch( "spec/.*/*_spec\.rb" ) do |match|
  system   'clear'
  run_spec match[ 0 ]
end

watch( "app/(.*/.*)\.rb" ) do |match|
  system   'clear'
  run_spec "spec/#{ match[ 1 ] }_spec.rb"
end

# ------------------------------------------------------------------
# Helpers

def run_spec( file )
  system 'clear'
  
  unless File.exist?( file )
    puts "#{ file } does not exist."
    return
  end

  puts   "Running #{ file } ..."
  system "bundle exec rspec #{ file }"
end

def run_all_tests
  system 'clear'
  
  puts   "Running all tests ..."
  system "bundle exec rspec spec"
end
