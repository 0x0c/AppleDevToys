# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'DevToys' do
  # Comment the next line if you don't want to use dynamic frameworks
  # use_frameworks!
  use_frameworks! :linkage => :static

  pod 'CombineExt'
  pod 'CompositionalLayoutViewController', :git => 'https://github.com/oneinc-jp/CompositionalLayoutViewController.git', :branch => 'develop'
  pod 'CompositionalLayoutViewControllerViperExtension', :git => 'https://github.com/0x0c/CompositionalLayoutViewControllerViperExtension.git', :branch => 'main'
  pod 'Drops', :git => 'https://github.com/omaralbeik/Drops.git'
  pod 'Gedatsu', :configuration => ['Debug']
  pod 'JWTDecode'
  pod 'Reusable'
  pod 'SFSafeSymbols'

  pod 'SwiftLint'
  pod 'SwiftFormat/CLI'
  pod 'R.swift'
  # pod 'Periphery'

  post_install do |installer|  
    require 'fileutils'
    FileUtils.cp_r('Pods/Target Support Files/Pods-DevToys/Pods-DevToys-acknowledgements.plist', 'DevToys/Resource/Settings.bundle/Acknowledgements.plist', :remove_destination => true)
  end
end
