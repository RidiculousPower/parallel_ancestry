
module ::ParallelAncestry::Inheritance
  
  # Provides hooks for inheritance events:
  # * Initialization:       :initialize_inheritance!
  # * First include:        :initialize_base_instance_for_include
  # * First extend:         :initialize_base_instance_for_extend
  # * Subsequent includes:  :initialize_inheriting_instance
  
  extend ::Module::Cluster

  ##################################################################################################
  ##################################  Inheritance Initialization  ##################################
  ##################################################################################################

  # We want to enable any module extended with self or any subclass of Module including self

  # Initialize any module extended with self for inheritance hooks
  cluster( :parallel_ancestry ).after_extend do |inheritance_module|
    inheritance_module.initialize_inheritance_for_module!
  end

  # Initialize any subclass of module including self for inheritance hooks
  cluster( :parallel_ancestry ).after_include do |class_instance|
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

    @initialized_inheritance_for_instance = { }
    
    extend ::Module::Cluster
    
    # When inheritance module is included in another module:
    cluster( :parallel_ancestry ).before_include do |base_instance|
      initialize_base_instance_for_include( base_instance )
    end

    # When inheritance module is used to extend another module:
    cluster( :parallel_ancestry ).before_extend do |base_instance|
      initialize_base_instance_for_extend( base_instance )
    end
    
    return self
    
  end
  
  ##################################################################################################
  ##############################  Base Configuration Initialization  ###############################
  ##################################################################################################
  
  ##########################################
  #  initialize_base_instance_for_include  #
  ##########################################
  
  def initialize_base_instance_for_include( inheriting_instance )

    # Initialize for future inheriting instances.
    return initialize_inheritance( inheriting_instance )
    
  end

  #########################################
  #  initialize_base_instance_for_extend  #
  #########################################

  def initialize_base_instance_for_extend( inheriting_instance )
  
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

    unless @initialized_inheritance_for_instance[ instance ]

      inheritance_module = self

      if instance.is_a?( ::Class )

        instance.extend( ::Module::Cluster )
        
        instance.cluster( :parallel_ancestry ).subclass do |inheriting_subclass|
          inheritance_module.initialize_inheriting_instance( instance, inheriting_subclass, true )
          inheritance_module.initialize_inheritance( inheriting_subclass )
        end

      else

        instance.extend( ::Module::Cluster )

        instance.cluster( :parallel_ancestry ).before_include do |inheriting_module|
          inheritance_module.initialize_inheriting_instance( instance, inheriting_module )
          inheritance_module.initialize_inheritance( inheriting_module )
        end

        instance.cluster( :parallel_ancestry ).before_extend do |inheriting_module|
          inheritance_module.initialize_inheriting_instance( instance, inheriting_module, false, true )
        end
        
      end

      @initialized_inheritance_for_instance[ instance ] = true
    
    end
  
  end

  ####################################
  #  initialize_inheriting_instance  #
  ####################################

  def initialize_inheriting_instance( parent_instance, inheriting_instance, for_subclass = false, is_extending = false )

    # Hook for extended module to redefine - nothing to do.

    return inheriting_instance
    
  end

end
