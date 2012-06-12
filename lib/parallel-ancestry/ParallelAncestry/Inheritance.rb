
module ::ParallelAncestry::Inheritance
  
  # Provides hooks for inheritance events:
  # * Initialization:       :initialize_inheritance!
  # * First include:        :initialize_base_instance_for_include
  # * First extend:         :initialize_base_instance_for_extend
  # * Subsequent includes:  :initialize_inheriting_instance
  
  extend ModuleCluster::Define::Block::ClassOrModule

  ##################################################################################################
  ##################################  Inheritance Initialization  ##################################
  ##################################################################################################

  # We want to enable any module extended with self or any subclass of Module including self

  # Initialize any module extended with self for inheritance hooks
  module_extend do |inheritance_module|
    inheritance_module.initialize_inheritance_for_module!
  end

  # Initialize any subclass of module including self for inheritance hooks
  class_include do |class_instance|
    if class_instance < ::Module
      class_instance.module_eval do
        include( ::ParallelAncestry::Inheritance::ModuleSubclassInheritance )
      end
    end
  end
  
  ########################################
  #  initialize_inheritance_for_module!  #
  ########################################

  def initialize_inheritance_for_module!

    @initialized_inheriting_instance = { }
    
    extend( ::ModuleCluster::Define::Block::ClassOrModuleOrInstance )
    
    # When inheritance module is included in another module:
    prepend_class_or_module_include do |base_instance|
      initialize_base_instance_for_include( self, base_instance )
    end

    # When inheritance module is used to extend another module:
    prepend_class_or_module_or_instance_extend do |base_instance|
      initialize_base_instance_for_extend( self, base_instance )
    end
    
    return self
    
  end
  
  ##################################################################################################
  ##############################  Base Configuration Initialization  ###############################
  ##################################################################################################
  
  ##########################################
  #  initialize_base_instance_for_include  #
  ##########################################
  
  def initialize_base_instance_for_include( inheritance_module, inheriting_instance )

    # Initialize for future inheriting instances.
    return initialize_inheritance( inheriting_instance )
    
  end

  #########################################
  #  initialize_base_instance_for_extend  #
  #########################################

  def initialize_base_instance_for_extend( inheritance_module, inheriting_instance )
  
    # Hook for extended module to redefine - nothing to do.
    
    return inheriting_instance
    
  end

  ##################################################################################################
  ###########################  Inheriting Configuration Initialization  ############################
  ##################################################################################################

  ############################
  #  initialize_inheritance  #
  ############################
  
  def initialize_inheritance( instance )
    
    unless @initialized_inheriting_instance[ instance ]

      inheritance_module = self

      if instance.is_a?( ::Class )

        instance.extend( ::ModuleCluster::Define::Block::Subclass )

        instance.subclass do |inheriting_subclass|
          inheritance_module.initialize_inheriting_instance( instance, inheriting_subclass, true )
        end

      else

        instance.extend( ::ModuleCluster::Define::Block::ClassOrModuleOrInstance )

        instance.class_or_module_include do |inheriting_module|
          inheritance_module.initialize_inheriting_instance( instance, inheriting_module )
          inheritance_module.initialize_inheritance( inheriting_module )
        end

        instance.class_or_module_or_instance_extend do |inheriting_module|
          inheritance_module.initialize_inheriting_instance( instance, inheriting_module )
        end
        
      end

      @initialized_inheriting_instance[ instance ] = true
    
    end
  
  end

  ####################################
  #  initialize_inheriting_instance  #
  ####################################

  def initialize_inheriting_instance( parent_instance, inheriting_instance, for_subclass = false )

    # Hook for extended module to redefine - nothing to do.

    return inheriting_instance
    
  end

end
