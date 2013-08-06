# -*- encoding : utf-8 -*-

###
# Extends ParallelAncestry singleton for registering singleton parent for module include.
#
module ::ParallelAncestry::ModuleActsLikeSubclass::Register
  
  ######################
  #  register_include  #
  ######################

  def register_include( class_or_module, including_module )
    
    register_parent( class_or_module, including_module )
    super

  end

  #####################
  #  register_extend  #
  #####################

  def register_extend( instance, extending_module )

    parents( instance ).register_parent( instance_parents( extending_module ), 1 )

  end

end
