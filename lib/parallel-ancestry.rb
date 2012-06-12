
require 'module-cluster'

module ::ParallelAncestry
  
end

basepath = 'parallel-ancestry/ParallelAncestry'

files = [
  
  'Inheritance',
  'Inheritance/ModuleSubclassInheritance',

  'ModuleSubclassInheritance'
    
]

files.each do |this_file|
  require_relative( File.join( basepath, this_file ) + '.rb' )
end

require_relative( basepath + '.rb' )
