Pod::Spec.new do |s|
  s.ios.deployment_target = '4.0'
  s.osx.deployment_target = '10.7'
  s.name                  = 'RegEx-Categories'
  s.version               = '1.1.0'
  s.summary               = 'NSRegularExpression extensions that make regular expressions easier in Objective-C or Swift'
  s.homepage              = 'https://github.com/bendytree/Objective-C-RegEx-Categories'
  s.license               = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.author                = { 'Josh Wright' => 'josh@bendytree.com' }
  s.source                = { :git => 'https://github.com/bendytree/Objective-C-RegEx-Categories.git', :tag => "v#{s.version.to_s}" }
  s.source_files          =  '*.{h,m}'
  s.requires_arc          = true
end