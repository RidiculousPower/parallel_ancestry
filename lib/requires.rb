# -*- encoding : utf-8 -*-

basepath = 'parallel_ancestry'

files = [
  
  'inheritance',
  'inheritance/module_subclass_inheritance',

  'module_subclass_initialization'
    
]

files.each do |this_file|
  require_relative( File.join( basepath, this_file ) + '.rb' )
end
