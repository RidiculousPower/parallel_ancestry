# -*- encoding : utf-8 -*-

require 'call_super'
require 'array/unique/compositing'

# namespaces that have to be declared ahead of time for proper load order
require_relative './namespaces'

# source file requires
require_relative './pre_requires.rb'

module ::ParallelAncestry
  extend ::ParallelAncestry::Ancestors
  extend ::ParallelAncestry::Bootstrap
end

#require_relative './post_requires.rb'
