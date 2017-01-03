Pod::Spec.new do |s|
  s.name             = 'ZITOOSDK'
  s.version          = '0.1.1'
  s.summary          = 'easyPay ZITOOSDK.'
  s.description      = <<-DESC
  智慧支付  一键开启
                       DESC

  s.homepage         = 'http://www.rtkj.com.cn'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sunnymoteng' => '369074420@qq.com' }
  s.source           = { :git => 'https://github.com/sunnymoteng/ZITOOSDK.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.default_subspec = 'BaseCore', 'Alipay','WXPay'


  s.subspec 'BaseCore' do |core|
       core.source_files = 'lib/*.h'
       core.public_header_files = 'lib/*.h'
       core.vendored_libraries = 'lib/*.a'
       core.frameworks = 'CFNetwork', 'SystemConfiguration', 'Security'
       core.ios.library = 'c++', 'stdc++', 'z'
       core.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }
  end

  s.subspec 'Alipay' do |ss|
     ss.vendored_libraries = 'lib/Channels/AliPaySDK/*.a'
     ss.ios.vendored_frameworks = 'lib/Channels/AliPaySDK/AlipaySDK.framework'
     ss.resource = 'lib/Channels/AliPaySDK/AlipaySDK.bundle'
     ss.frameworks = 'CoreMotion', 'CoreTelephony'
     ss.dependency 'ZITOOSDK/BaseCore'
  end

  s.subspec 'WXPay' do |wx|
     wx.frameworks = 'CoreTelephony'
     wx.vendored_libraries = 'lib/Channels/WeChatSDK/*.a'
     wx.ios.library = 'sqlite3'
     wx.dependency 'ZITOOSDK/BaseCore'
  end
end
