Pod::Spec.new do |s|
  s.name             = 'BDMirrorView'
  s.version          = '0.1.0'
  s.summary          = 'A live reflecting UIView using CAReplicatorLayer and CAGradientLayer'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
BDMirrorView is a UIView subclass, designed to make it easy to create \"mirrored floor\"-style reflections of views on iOS.\n\n  It uses CAReplicatorLayer and CAGradientLayer internally, and allows you to compose mirroring effects without relying on CPU-drawing. You may have noticed that Apple provides a Reflection sample project for this, but Apple's solution works only with images and involves fairly slow CPU-bound drawing to update the reflection, which renders it unsuitable for non-static content. BDMirrorView works in real-time on any view.
                       DESC

  s.homepage         = 'https://github.com/viewDidAppear/BDMirrorView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Benjamin Deckys' => 'ben.kawabata@gmail.com' }
  s.source           = { :git => 'https://github.com/viewDidAppear/BDMirrorView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'BDMirrorView/Classes/**/*'

end
