# -*- encoding : utf-8 -*-

###
# Provides support for instance to register parent prior to initialization.
#   Use by including ::Provides::Hooks::Instance, which will extend class with this module.
#
module ::ParallelAncestry::Hooks::New

  #########
  #  new  #
  #########
  
  ###
  # Registers instance as child of self when created, before initialize_chain.
  #
  # @overload initialize( any_arg, ... )
  #
  #   @param [Object] any_arg
  #
  #                   Any arguments can be used for initialize.
  #                   No arguments are expected here, but any will be passed to super.
  #
  def new( *args, & block )

    instance = allocate
    instance.initialize«parent_registration»( self )
    instance.initialize_chain( *args, & block )
    
    return instance
    
  end

  ##############################
  #  new«inheriting_instance»  #
  ##############################
  
  ###
  # Registers instance as child of specified parent when created, before initialize_chain.
  #
  # @overload initialize( any_arg, ... )
  #
  #   @param [Object] any_arg
  #
  #                   Any arguments can be used for initialize.
  #                   No arguments are expected here, but any will be passed to super.
  #
  def new«inheriting_instance»( parent_instance, *args, & block )
    
    instance = allocate
    instance.initialize«parent_registration»( parent_instance )
    instance.initialize_chain( *args, & block )
    
    return instance    
    
  end
  
end

