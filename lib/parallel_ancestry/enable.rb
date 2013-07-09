# -*- encoding : utf-8 -*-

module ::ParallelAncestry::Enable

  ###############
  #  inherited  #
  ###############
  
  def inherited( subclass )
    
    super if defined?( super )
    
    ::ParallelAncestry.register_instance_parent( subclass, self )
    
    cluster = subclass.extend( ::Module::Cluster ).cluster( :parallel_ancestry )
    cluster.before_instance { |instance| ::ParallelAncestry.register_singleton_parent( instance, self ) }
    
  end
  
end
