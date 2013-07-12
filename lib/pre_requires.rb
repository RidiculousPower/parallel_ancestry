# -*- encoding : utf-8 -*-

[

  'parallel_ancestry/ancestors',
  'parallel_ancestry/bootstrap',
  
  'parallel_ancestry/hash',
  'parallel_ancestry/array',
  'parallel_ancestry/array/unique_by_id',
  
  'parallel_ancestry/enable/extend',
  'parallel_ancestry/enable/include',
  'parallel_ancestry/enable/included_extended',
  'parallel_ancestry/enable/inherited',

  'parallel_ancestry/ancestors/parents',
  'parallel_ancestry/ancestors/children',

  'parallel_ancestry/ancestors/instance_parents',
  'parallel_ancestry/ancestors/instance_children',

  'parallel_ancestry/ancestry_struct'

].each { |this_file| require_relative( this_file << '.rb' ) }
