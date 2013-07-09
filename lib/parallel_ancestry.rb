# -*- encoding : utf-8 -*-

require 'call_super'
require 'pre_and_post_initialize'
require 'array/unique'

# namespaces that have to be declared ahead of time for proper load order
require_relative './namespaces'

# source file requires
require_relative './pre_requires.rb'

module ::ParallelAncestry
  
  extend ::ParallelAncestry::InstanceParents
  extend ::ParallelAncestry::InstanceChildren
  extend ::ParallelAncestry::SingletonParents
  extend ::ParallelAncestry::SingletonChildren
  
  @ancestors_hash = { }
  
  ##########################
  #  self.ancestry_struct  #
  ##########################
  
  ###
  # Retrieve struct containing ancestry information for instance.
  #
  # @param [Object] instance 
  #
  #        Child instance.
  #
  # @return [ParallelAncestry::Ancestors::InstanceStruct] 
  #
  #         Struct for instance.
  #
  def self.ancestry_struct( instance )

    unless ancestry_struct = @ancestors_hash[ instance_id = instance.__id__ ]
      @ancestors_hash[ instance_id ] = ancestry_struct = self::AncestryStruct.new
      # Most objects will register by hook. 
      # This is true for:
      # * class instances
      # * instances of classes inheriting from Module
      # * instances of classes inheriting from Object
      # This is not true for:
      # * instances of Module created by parser 
      register_singleton_parent( instance, ::Module, ancestry_struct ) if instance.class.equal?( ::Module )
    end

    return ancestry_struct
    
  end
  
end

require_relative './post_requires.rb'

::ParallelAncestry.register_instance_parent( ::Object, ::Class )
::ParallelAncestry.register_singleton_parent( ::Module, ::Object )
::ParallelAncestry.register_instance_parent( ::Module, ::Object )
