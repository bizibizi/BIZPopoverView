Pod::Spec.new do |s|
  s.name         = "BIZPopoverView"
  s.version      = '1.0.0'
  s.summary      = "BIZPopoverView is a custom popover as ContentView of that can be used any content of any UIViewController.  "
  s.homepage     = "https://github.com/bizibizi/BIZPopoverView"
  s.license               = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "Igor Bizi" => "igorbizi@mail.ru" }
  s.platform              = :ios, '7.0'
  s.source       = { :git => "https://github.com/bizibizi/BIZPopoverView.git", :tag => '1.0.0' }
  s.source_files          = 'Classes/*.{h,m}'
  s.public_header_files   = 'Classes/*.h'
  s.frameworks            = 'UIKit', 'Foundation', 'QuartzCore'
  s.requires_arc          = true
end
