Pod::Spec.new do |s|
    s.name         = 'Stinsen'
    s.version      = '2.0.9'
    s.summary      = 'Simple, powerful and elegant implementation of the Coordinator pattern in SwiftUI.'
    s.homepage     = 'https://github.com/rundfunk47/stinsen'
    s.license      = { :type => 'MIT License' }
    s.author      = { 'Narek Mailian' => 'narek.mailian@gmail.com' }
    s.source       = { :git => 'https://github.com/rundfunk47/stinsen.git', :tag => s.version }
    s.source_files = 'Sources/Stinsen/**/*.swift'
    s.framework    = 'SwiftUI'
    s.ios.deployment_target  = '13.0'
    s.swift_version = '5.3'
end
