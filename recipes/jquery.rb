gem "jquery-rails"

stategies << lambda do
  # Do special things to get around the HTTPS issue with Ruby 1.9.2 on Win32
  inside('config') do
    run 'cp environment.rb environment.~'
    say_status "info", "Overriding OpenSSL to not verify CA chain for jQuery install.", :yellow
    say_status "info", "    expect warning about already initialized constant VERIFY_PEER", :yellow
    gsub_file 'environment.rb', '# Load the rails application', "require 'openssl'\nOpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE"
    generate 'jquery:install --ui'
    run 'mv environment.~ environment.rb'   # resotre the original file without the hackery
  end
end