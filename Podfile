platform :ios, '14.2'

inhibit_all_warnings!

def pmlTimes_pod
  pod 'Moya/RxSwift', '14.0.0'
  pod 'RxSwift', '5.1.1'
  pod 'Moya-ObjectMapper/RxSwift', '2.9'
  pod 'RxCocoa', '5.1.1'
  pod 'RxOptional', '4.1.0'
  pod 'RxDataSources', '4.0.1'
  pod 'Kingfisher', '~> 7.0'
  pod 'FirebaseCore'
  pod 'FirebaseFirestoreSwift', '~> 7.0-beta'
  pod 'UIScrollView-InfiniteScroll', '1.1.0'
end

target 'PMLTimes' do
  use_frameworks!
  # Pods for PMLTimes
  pmlTimes_pod
  
  target 'PMLTimesTests' do
    inherit! :search_paths
    # Pods for testing
    pmlTimes_pod
  end
  
  target 'PMLTimesUITests' do
    # Pods for testing
  end
  
end

post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.2'
  end
 end
end

