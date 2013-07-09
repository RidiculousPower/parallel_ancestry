# -*- encoding : utf-8 -*-

[

  'parallel_ancestry/array',
  'parallel_ancestry/array/unique_by_id',
  
  'parallel_ancestry/enable',
  'parallel_ancestry/enable/object',
  'parallel_ancestry/instance_parents',
  'parallel_ancestry/instance_children',
  'parallel_ancestry/singleton_parents',
  'parallel_ancestry/singleton_children',

  'parallel_ancestry/ancestry_struct'

].each { |this_file| require_relative( this_file << '.rb' ) }
