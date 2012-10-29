Pod::Spec.new do |s|
  s.name     = 'GRGridView'
  s.version  = '0.0.1'
  s.license  = 'MIT'
  s.summary  = 'A grid view that allows objects to occupy more than one row/column.'
  s.homepage = 'https://github.com/gabrielrinaldi/GRGridView'
  s.authors  = {'Gabriel Rinaldi' => 'gabriel@gabrielrinaldi.me', 'Kristopher Johnson' => 'kris@kristopherjohnson.net'}
  s.source   = { :git => 'https://github.com/gabrielrinaldi/GRGridView.git', :commit => '73c9d39f378cf138bb9ff478ff0ab6025ab39c3a' }
  s.source_files = 'GRGridView/Classes'
  s.requires_arc = true
  s.platform = :ios
end
