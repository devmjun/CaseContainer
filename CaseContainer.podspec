Pod::Spec.new do |s|
  s.name                  = "CaseContainer"
  s.version               = "0.9.3"
  s.summary               = "Container view controller with Parallax TableView"

  s.homepage              = "https://github.com/devmjun/CaseContainer"
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.author                = { "Minjun Ju" => "dev.mjun@gmail.com" }

  
  s.source                = { :git => "https://github.com/devmjun/CaseContainer.git", 
                              :tag => s.version.to_s }
  s.source_files          = "Sources/**/*"
  s.exclude_files         = "Sources/**/*.plist"

  s.ios.deployment_target = "9.0"
  s.swift_version         = "4.2"
end
