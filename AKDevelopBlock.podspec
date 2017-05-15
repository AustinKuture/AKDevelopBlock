

Pod::Spec.new do |s|


  s.name         = "AKDevelopBlock"

  s.version      = "0.0.1"

  s.summary      = "DevelopBlock Model For AustinKuture"

  s.homepage     = "https://github.com/AustinKuture/AKDevelopBlock"

  s.license      = "MIT"
 
  s.author             = { "AustinKuture" => "austinkuture@126.com" }

  # s.platform     = :ios
  # s.platform     = :ios, "5.0"

  s.source       = { :git => "https://github.com/AustinKuture/AKDevelopBlock.git", :tag => "#{s.version}" }

  s.source_files  = "AKHttpsSignature/HttpsSignatureCertificate/AKNetPackegeAFN.{h,m}"


  
end
