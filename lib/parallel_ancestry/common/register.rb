# -*- encoding : utf-8 -*-

###
# Extends ParallelAncestry singleton for registering objects
#
module ::ParallelAncestry::Common::Register

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

    register_parent( instance, extending_module )

  end

  #######################
  #  register_instance  #
  #######################

  def register_instance( instance, parent_instance )

    register_parent( instance, parent_instance )

  end

end
