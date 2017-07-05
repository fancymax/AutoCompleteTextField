Pod::Spec.new do |s|
    s.name = 'AutoCompleteTextFieldClassic'
    s.version = '1.0.5'
    s.license = 'MIT'

    s.summary = 'AutoCompleteTextField for OS X'
    s.homepage = 'https://github.com/fancymax/AutoCompleteTextField'
    s.author = 'Max Lin'
    s.source = { :git => 'https://github.com/fancymax/AutoCompleteTextField.git', :tag => s.version.to_s }

    s.frameworks = 'Foundation'
    s.requires_arc = true

    s.osx.deployment_target = '10.10'
    s.source_files = 'AutoCompleteTextField.swift'
end
