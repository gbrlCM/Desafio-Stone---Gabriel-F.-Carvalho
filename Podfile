# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

def rx_swift
  pod 'RxSwift'
  pod 'RxRelay'
  pod 'RxCocoa'
end

def rx_test
  pod 'RxTest'
  pod 'RxBlocking'
end

def all_dependencies
  rx_swift
  rx_test
end

target 'StoneChallenge' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  rx_swift

  # Pods for StoneChallenge

  target 'StoneChallengeTests' do
    inherit! :search_paths
    rx_test
    # Pods for testing
  end

end
