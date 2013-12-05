Pod::Spec.new do |s|
  s.name         = 'Objective-C Regex Categories'
  s.version      = '1.0'
  s.license      = { :type => 'MIT' }
  s.homepage     = 'https://github.com/bendytree/Objective-C-RegEx-Categories'
  s.authors      = { 'Josh Wright' => 'josh@joshwright.com' }
  s.summary      = 'Categories on NSRegularExpression that make regular expressions more concise in Objective-C.'
  s.source       = { :git => 'https://github.com/bendytree/Objective-C-RegEx-Categories.git', :tag => "v1.0" }
  s.source_files = 'RegExCategories.{h,m}'
  s.framework    = 'Foundation'
end