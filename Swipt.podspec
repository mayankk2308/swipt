Pod::Spec.new do |spec|
    spec.name = 'Swipt'
    spec.version = '1.0.0'
    spec.osx.deployment_target = '10.10'
    spec.license = { :type => 'MIT', :file => 'LICENSE.md' }
    spec.source = { :git => 'https://github.com/mayankk2308/swipt.git', :tag => spec.version.to_s}
    spec.authors = {'Mayank Kumar' => 'mayankk2308@gmail.com'}
    spec.homepage = 'https://github.com/mayankk2308/swipt'
    spec.swift_version = '4.1'
    spec.summary = 'Swipt is an easy-to-use API that enables developers to execute shell scripts directly in Swift.'
    spec.source_files = 'Swipt/*.swift'
end
