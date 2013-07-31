# -*- encoding : utf-8 -*-

###
# Extends ParallelAncestry singleton for registering singleton parent for module include.
#
module ::ParallelAncestry::IncludeActsLikeSubclass::Register
  
  ######################
  #  register_include  #
  ######################

  def register_include( class_or_module, including_module )
    
    register_parent( class_or_module, including_module )
    super

  end

end
