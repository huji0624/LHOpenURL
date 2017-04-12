Pod::Spec.new do |s|
  s.name         = "LHOpenURL"
  s.version      = "1.0.2"
  s.summary      = "iOS open url framework.Auto documentGenerate."
  s.homepage     = "https://github.com/huji0624/LHOpenURL"

  s.license      = { :type => 'MIT'}
  s.author       = { "huji" => "huji0624@gmail.com" }

  s.source       = { :git => "https://github.com/huji0624/LHOpenURL.git", :tag => "1.0.1" }

  s.ios.deployment_target = '7.0'

  s.source_files = 'LHOpenURL/**/*.{m,h}'
  s.public_header_files = 'LHOpenURL/**/*.h'

  s.requires_arc = true

end
