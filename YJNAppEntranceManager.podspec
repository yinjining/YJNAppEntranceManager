#
# Be sure to run `pod lib lint YJNAppEntranceManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|

s.name         = "YJNAppEntranceManager"
s.version      = "1.0.0"
s.summary      = "AppDelegate管理"
s.platform     = :ios, "8.0"
s.description  = <<-DESC
 appdelegate 管理
DESC
s.homepage     = "https://github.com/yinjining/YJNAppEntranceManager"
s.author             = { "殷继宁" => "921652053@qq.com" }
s.license       = {
:type => 'MIT',
:text => <<-LICENSE

LICENSE
}

s.ios.deployment_target = "8.0"
s.source       = { :git => "https://github.com/yinjining/YJNAppEntranceManager.git", :tag => "#{s.version}" }

s.subspec 'YJNAPP' do |ss|
   ss.public_header_files = "YJNAppEntranceManagerDemo/YJNAppEntranceManager/YJNAPP/*.h"
   ss.source_files        = "YJNAppEntranceManagerDemo/YJNAppEntranceManager/YJNAPP/*.{h,m,mm,c,cc,cpp}"
end

s.subspec 'YJNScene' do |ss|
   ss.public_header_files = "YJNAppEntranceManagerDemo/YJNAppEntranceManager/YJNScene/*.h"
   ss.source_files        = "YJNAppEntranceManagerDemo/YJNAppEntranceManager/YJNScene/*.{h,m,mm,c,cc,cpp}"
end

s.requires_arc = true
s.frameworks = "Foundation","UIKit"

end
