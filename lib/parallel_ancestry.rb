# -*- encoding : utf-8 -*-

require 'call_super'
require 'array/unique/compositing'

module ::ParallelAncestry
  module Common
  end
end

[

  'parallel_ancestry/parents_array',
  'parallel_ancestry/instance_parents_array',
  'parallel_ancestry/modules',

  'parallel_ancestry/inherited',
  'parallel_ancestry/included_extended',

  'parallel_ancestry/common/parents',
  'parallel_ancestry/common/children',
  'parallel_ancestry/common/bootstrap',
  'parallel_ancestry/common/register',
  'parallel_ancestry/common/unregister',
  'parallel_ancestry/common'

].each { |this_file| require_relative( this_file << '.rb' ) }

module ::ParallelAncestry
  extend ::ParallelAncestry::Modules
end

class ::Object
  extend ::ParallelAncestry::Inherited
end

class ::Module
  include ::ParallelAncestry::IncludedExtended
end
