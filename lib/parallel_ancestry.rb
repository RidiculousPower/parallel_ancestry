
require 'module/cluster'
require 'array/unique'

module ::ParallelAncestry
  
end

basepath = 'parallel_ancestry/parallel_ancestry'

files = [
  
  'inheritance',
  'inheritance/module_subclass_inheritance',

  'module_subclass_inheritance'
    
]

files.each do |this_file|
  require_relative( File.join( basepath, this_file ) + '.rb' )
end

require_relative( basepath + '.rb' )
