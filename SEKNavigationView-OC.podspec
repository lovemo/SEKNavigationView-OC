Pod::Spec.new do |s|
s.name                  = 'SEKNavigationView-OC'
s.version      = '0.0.2'
s.summary               = 'SEKNavigationView is a easy to develop iOS'
s.homepage              = 'https://github.com/lovemo/SEKNavigationView-OC'
s.platform     = :ios, '7.0'
s.license               = 'MIT'
s.author                = { 'lovemo' => 'lovemomoyulin@qq.com' }
s.source                = { :git => 'https://github.com/lovemo/SEKNavigationView-OC.git',:tag => s.version.to_s }
s.source_files     = 'SEKNavigationView/*'
s.requires_arc          = true
s.frameworks             = 'Foundation', 'UIKit'

end
