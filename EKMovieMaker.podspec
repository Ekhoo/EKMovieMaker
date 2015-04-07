#
# Be sure to run `pod lib lint EKMovieMaker.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "EKMovieMaker"
  s.version          = "0.0.1"
  s.summary          = "Convert an array of UIImage into a movie."
  s.description      = "Light tool which convert an array of UIImage into a movie, written in Objective-C."
  s.homepage         = "https://github.com/Ekhoo/EKMovieMaker"
  s.license          = 'MIT'
  s.author           = { "Ekhoo" => "me@lucas-ortis.com" }
  s.source           = { :git => "https://github.com/Ekhoo/EKMovieMaker.git", :tag => s.version.to_s }
  s.platform         = :ios, '6.0'
  s.requires_arc     = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'EKMovieMaker' => ['Pod/Assets/*.png']
  }

end
