# -*- encoding : utf-8 -*-

###
# Extends ParallelAncestry singleton for tracking objects
#
module ::ParallelAncestry::Common::Children
  
  ###############
  #  is_child?  #
  ###############
  
  def is_child?( instance, potential_child  )
    
    return is_parent?( potential_child, instance )
    
  end

  ########################
  #  is_instance_child?  #
  ########################
  
  def is_instance_child?( instance, potential_child  )
    
    return is_instance_parent?( potential_child, instance )
    
  end

end
