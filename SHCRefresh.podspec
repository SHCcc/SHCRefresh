Pod::Spec.new do |s|

s.name         = "SHCRefresh"
s.version      = "1.0.0"
s.summary      = "swift的下拉刷新控件"
s.description  = "一个swift4的TableView刷新控件,膳小二的自定义刷新控件"
s.homepage     = "https://github.com/SHCcc/SHCRefresh"
s.license      = "MIT"
s.ios.deployment_target = "8.0"
s.author             = { "SHCcc" => "578013836@qq.com" }
s.source       = { :git => "https://github.com/SHCcc/SHCRefresh.git", :tag => s.version.to_s }

s.source_files  = ["SHCRefresh/**", "SHCRefresh/*/**"]
s.requires_arc = true
s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
end


