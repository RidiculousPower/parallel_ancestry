# -*- encoding : utf-8 -*-

###
# Extends ParallelAncestry singleton for unregistering objects
#
module ::ParallelAncestry::Common::Unregister

  #######################
  #  unregister_parent  #
  #######################
  
  ###
  # Unregister instance as child of another instance.
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
  def unregister_parent( instance, parent )

    if parents = parents( instance, false )
      parents.unregister_parent( parents( parent ) )
    end
    
    return self

  end

  ################################
  #  unregister_instance_parent  #
  ################################
  
  ###
  # Unregister instance as child of another instance.
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
  def unregister_instance_parent( instance, parent )

    if parents = instance_parents( instance, false )
      parents.unregister_parent( instance_parents( parent ) )
    end
    
    return self

  end

  ###################################
  #  unregister_instance_of_parent  #
  ###################################
  
  ###
  # Unregister instance as instance of another instance.
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
  def unregister_instance_of_parent( instance, parent )

    if parents = parents( instance, false )
      parents.unregister_parent( instance_parents( parent ) )
    end
    
    return self

  end

end
