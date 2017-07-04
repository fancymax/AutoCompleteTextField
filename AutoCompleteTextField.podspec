Pod::Spec.new do |s|
    s.name = 'AutoCompleteTextField'
    s.version = '1.0.1'
    s.license = 'MIT'

    s.summary = 'AutoCompleteTextField for OS X'
    s.homepage = 'https://github.com/fancymax/AutoCompleteTextField'
    s.author = 'Max Lin'
    s.source = { :git => 'https://github.com/mipmip/AutoCompleteTextField.git', :tag => s.version.to_s }
    s.social_media_url = 'http://fancywt.cn'

    s.frameworks = 'Foundation'
    s.requires_arc = true

    s.osx.deployment_target = '10.9'
    s.source_files = 'AutoCompleteTextField.swift'
end
