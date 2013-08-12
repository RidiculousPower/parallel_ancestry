# -*- encoding : utf-8 -*-

###
# Provides support to ParallelAncestry to register modules that define 
#   extended behavior when include/extend/subclass/instance occurs.
#
module ::ParallelAncestry::Modules

  ###################
  #  self.extended  #
  ###################

  def self.extended( instance )
    
    instance.module_eval { @modules = ::Array::Unique.new }
    
  end

  #############
  #  suspend  #
  #############
  
  def suspend
    
    @suspended = true

    if block_given?
      yield
      @suspended = false
    end
    
  end

  ############
  #  resume  #
  ############
  
  def resume

    @suspended = false
    
  end

  ################
  #  suspended?  #
  ################
  
  def suspended?

    return @suspended ||= false
    
  end

  #####################
  #  register_module  #
  #####################

  def register_module( parallel_ancestry_module )
    
    @modules.push( parallel_ancestry_module )
    
  end
  
  #######################
  #  register_subclass  #
  #######################
  
  def register_subclass( subclass, superclass )
    
    @modules.each { |this_module| this_module.register_subclass( subclass, superclass ) } unless @suspended
    
  end

  ######################
  #  register_include  #
  ######################

  def register_include( class_or_module, including_module )
    
    @modules.each { |this_module| this_module.register_include( class_or_module, including_module ) } unless @suspended

  end

  #####################
  #  register_extend  #
  #####################

  def register_extend( instance, extending_module )

    @modules.each { |this_module| this_module.register_extend( instance, extending_module ) } unless @suspended

  end

  #######################
  #  register_instance  #
  #######################

  def register_instance( instance, parent_instance )

    @modules.each { |this_module| this_module.register_instance( instance, parent_instance ) } unless @suspended

  end  

end
