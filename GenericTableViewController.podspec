Pod::Spec.new do |s|
  s.name         = "GenericTableViewController"
  s.version      = "0.1.1"
  s.summary      = "Easy to configure generic table views"

  s.description  = <<-DESC
                   A `UIViewController` subclass displaying a table view that can be configured in a generic way.
                   Ideal to be used as a child view controller to quickly display simple lists.
                   DESC

  s.homepage     = "http://EXAMPLE/GenericTableViewController"
  s.license      = "Private Pod"
  s.author             = { "Gio Lodi" => "gio@mokacoding.com" }

  s.source       = { :git => "https://github.com/mokagio/GenericTableViewController.git" }


  s.source_files  = "Sources"
  s.requires_arc = true
  s.ios.deployment_target = '12.0'
  s.swift_version = '5'

  # Exclude arm64 to avoid isses post-Xcode 12
  # See https://stackoverflow.com/a/63955114/809944
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end

