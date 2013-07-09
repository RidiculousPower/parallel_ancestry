# -*- encoding : utf-8 -*-

module ::ParallelAncestry::Enable::Module

  #####################
  #  append_features  #
  #####################

  ###
  # Register instance parent.
  #
  # @param [Module,Class] hooked_instance
  #
  #        Instance being registered as child.
  #
  def append_features( hooked_instance )

    ::ParallelAncestry.register_instance_parent( hooked_instance, self )

    super if defined?( super )
    
  end

  ###################
  #  extend_object  #
  ###################

  ###
  # Register singleton parent.
  #
  # @param [Module,Class] hooked_instance
  #
  #        Instance being registered as child.
  #
  def extend_object( hooked_instance )

    ::ParallelAncestry.register_singleton_parent( hooked_instance, self )

    super if defined?( super )
    
  end
  
end
