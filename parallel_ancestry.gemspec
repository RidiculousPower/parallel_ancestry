require 'date'

Gem::Specification.new do |spec|

  spec.name                      =  'parallel_ancestry'
  spec.rubyforge_project         =  'parallel_ancestry'
  spec.version                   =  '1.0.2'

  spec.summary                   =  "Provides parallel implementations of inheritance hierarchies. This is useful both for tracking the existing inheritance tree and for creating trees that function independently of inheritance models determined internal to Ruby."
  spec.description               =  'Create and track parallel inheritance hierarchies. Hook parallel hierarchies (by including a module) to automatically update/register ancestry at include and extend, or update/register only manually. Manual registration permits definitions of ancestry across, for example, instances of the same type or instances of entirely different types. Implementation is provided by simple child/parent trees with an block to choose which parent. This permits a simple multiple inheritance model very similar to how Ruby handles modules. Conflicts for multiple inheritance are resolved by the parent most recently named for the block match. Used heavily by CascadingConfiguration gem (cascading-configuration) as well as by forthcoming Persistence and Magnets gems (persistence and magnets).'

  spec.authors                   =  [ 'Asher' ]
  spec.email                     =  'asher@ridiculouspower.com'
  spec.homepage                  =  'http://rubygems.org/gems/parallel_ancestry'

  spec.add_dependency            'call_super'
  spec.add_dependency            'pre_and_post_initialize'
  spec.add_dependency            'array-unique'

  spec.required_ruby_version     = ">= 1.9.1"

  spec.date                      = Date.today.to_s
  
  spec.files                     = Dir[ '{lib,lib_ext,spec}/**/*',
                                        'README*', 
                                        'LICENSE*',
                                        'CHANGELOG*' ]

end
