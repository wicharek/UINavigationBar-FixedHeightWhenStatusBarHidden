#
# Be sure to run `pod lib lint UINavigationBar-FixedHeightWhenStatusBarHidden.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UINavigationBar-FixedHeightWhenStatusBarHidden'
  s.version          = '1.1.0'
  s.summary          = 'This pod adds property to UINavigationBar class to keep its size even if status bar was hidden.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Normally on iOS 7+ navigation bar height equals to 64 px, when status bar is shown. After it is hidden, the height is changed to 44 px by default.
This category adds property `fixedHeightWhenStatusBarHidden` to UINavigationBar class. If set to YES navigation bar will keep its size even if status bar was hidden.
This is especially useful in case of "drawer"-styled side panel, when you want status bar to be hidden when this panel is shown.
                       DESC

  s.homepage         = 'https://github.com/wicharek/UINavigationBar-FixedHeightWhenStatusBarHidden'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Vitaliy Ivanov' => 'wicharek@gmail.com', 'Viktor Naryshkin' => 'ku6opr.mail@gmail.com' }
  s.source           = { :git => 'https://github.com/wicharek/UINavigationBar-FixedHeightWhenStatusBarHidden.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '8.0'

  s.source_files = 'UINavigationBar-FixedHeightWhenStatusBarHidden/*'
  
  # s.public_header_files = 'Pod/*.h'
  # s.frameworks = 'UIKit'
end
