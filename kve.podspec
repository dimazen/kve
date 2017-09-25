Pod::Spec.new do |s|
  s.name         = 'kve'
  s.version      = '0.1'
  s.summary      = 'Summary'
  s.description  = 'Description'

  s.homepage     = 'https://github.com/dimazen/kve'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Dima Vorona' => 'zen.dev@yandex.com' }
  s.source = { http: "https://github.com/dimazen/kve/releases/download/#{s.version}/kve.zip" }
  s.preserve_paths = '*'
end
