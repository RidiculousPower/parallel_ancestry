# -*- encoding : utf-8 -*-

require 'call_super'
require 'pre_and_post_initialize'
require 'module-cluster'
require 'array/unique/compositing'

module ::ParallelAncestry
  module Common
  end
  module Hooks
  end
  module Array
  end
end

[

  'parallel_ancestry/array/parents_array',
  'parallel_ancestry/array/instance_parents_array',

  'parallel_ancestry/modules',

  'parallel_ancestry/hooks/new',
  'parallel_ancestry/hooks/instance',
  'parallel_ancestry/hooks/inherited',
  'parallel_ancestry/hooks/included_extended',

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

[

  '../lib_ext/object',
  '../lib_ext/module'

].each { |this_file| require_relative( this_file << '.rb' ) }
