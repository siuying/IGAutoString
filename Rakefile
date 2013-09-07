desc "Run the IGAutoString Tests for iOS"
task :test do
  system("xctool -project IGAutoString.xcodeproj -scheme IGAutoString -sdk iphonesimulator -configuration Release test -test-sdk iphonesimulator test")
end

task :default => 'test'