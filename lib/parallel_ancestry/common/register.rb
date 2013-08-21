# -*- encoding : utf-8 -*-

###
# Extends ParallelAncestry singleton for registering objects
#
module ::ParallelAncestry::Common::Register

  #####################
  #  register_parent  #
  #####################
  
  ###
  # Register instance as child of another instance (singleton to singleton).
  #
  # @param [Object] instance 
  #
  #        Instance for which parent is being registered.
  #
  # @param [Object] parent 
  #
  #        Parent instance.
  #
  # @return Self.
  #
  def register_parent( instance, parent )

    parents( instance ).register_parent( parents( parent ), 1 )
    
    return self

  end

  ##############################
  #  register_instance_parent  #
  ##############################
  
  ###
  # Register instance as child of another instance (instance to instance).
  #
  # @param [Object] instance 
  #
  #        Instance for which parent is being registered.
  #
  # @param [Object] parent 
  #
  #        Parent instance.
  #
  # @return Self.
  #
  def register_instance_parent( instance, parent )

    instance_parents( instance ).register_parent( instance_parents( parent ), 1 )

    return self

  end

  #################################
  #  register_instance_of_parent  #
  #################################
  
  ###
  # Register instance as an instance of another instance (instance crosses to singleton).
  #
  # @param [Object] instance 
  #
  #        Instance for which parent is being registered.
  #
  # @param [Object] parent 
  #
  #        Parent instance.
  #
  # @return Self.
  #
  def register_instance_of_parent( instance, parent )

    parents( instance ).register_parent( instance_parents( parent ), 1 )

    return self

  end

  #######################
  #  register_subclass  #
  #######################
  
  def register_subclass( subclass, superclass )

    register_parent( subclass, superclass )
    register_instance_parent( subclass, superclass )
    
  end

  ######################
  #  register_include  #
  ######################

  def register_include( class_or_module, including_module )
    
    register_instance_parent( class_or_module, including_module )

  end

  #####################
  #  register_extend  #
  #####################

  def register_extend( instance, extending_module )

    parents( instance ).register_parent( instance_parents( extending_module ), 0 )

  end

  #######################
  #  register_instance  #
  #######################

  def register_instance( instance, parent_instance )
    
    unless ::Class === instance
      register_instance_of_parent( instance, parent_instance )
    end    

  end

end

