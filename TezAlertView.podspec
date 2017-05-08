Pod::Spec.new do |s|
	s.name               = "TezAlertView"
	s.version            = "0.2"
	s.summary            = "Custom singleton alertView with block completion"
	s.homepage           = "https://github.com/tezpark/TezAlertView"
	s.screenshots        = "https://cloud.githubusercontent.com/assets/389004/7901926/2855f8be-07dc-11e5-9123-20f1d1034987.png", "https://cloud.githubusercontent.com/assets/389004/7901927/2856dd60-07dc-11e5-944a-a39ee470715d.png"
	s.license            = { :type => "MIT", :file => "LICENSE" }
	s.author             = { "Tez Park" => "ptswin@gmail.com" }
	s.source             = { :git => "https://github.com/tezpark/TezAlertView.git", :tag => s.version.to_s }
	s.platform           = :ios, "8.0"

	s.source_files  = "TezAlertView/**/*.{h,m}"
end
