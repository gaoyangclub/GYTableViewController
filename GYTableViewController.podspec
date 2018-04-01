Pod::Spec.new do |s|
    s.name         = 'GYTableViewController'
    s.version      = '1.0.0'
    s.summary      = 'A simple and efficient table control with pull-to-refresh'
    s.homepage     = 'https://github.com/gaoyangclub/GYTableViewController'
    s.license      = 'MIT'
    s.authors      = {'高扬' => 'gaoyangclub@126.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/gaoyangclub/GYTableViewController.git', :tag => s.version}
    s.source_files = 'GYTableViewController/Framework/*.{h,m}'
    s.requires_arc = true
    s.dependency 'MJRefresh'
    s.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }
end
