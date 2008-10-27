require 'watir/browser'
case Watir::UnitTest.options[:browser]
when 'ie'
  $LOAD_PATH.unshift File.expand_path($watir_dev_lib)
  require 'watir'
  Watir::Browser.module_eval "@@klass = Watir::IE"

  at_exit {Watir::IE.quit}

  speed = Watir::UnitTest.options[:speed].to_sym
  Watir::IE.speed = speed
  $browser = Watir::Browser.new
  $browser.speed = speed
when 'firefox'
  $LOAD_PATH.unshift File.expand_path($firewatir_dev_lib)
  require 'firewatir'
  Watir::Browser.module_eval "@@klass = FireWatir::Firefox"  
  
  $browser = Watir::Browser.new
end

# close browser at completion of the tests
# the at_exit execute before loading test/unit, otherwise IE will close *before* the tests run.
at_exit {$browser.close if $browser}

