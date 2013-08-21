# -*- encoding : utf-8 -*-

###
# Provides support for instance to register parent prior to initialization.
#
module ::ParallelAncestry::Hooks::Instance
  
  extend ::Module::Cluster
  
  cluster = cluster( :parallel_ancestry_instance_hooks )
  cluster.before_include.cascade_to( :class ) do |class_instance|
    class_instance.extend( ::ParallelAncestry::Hooks::New )
  end

  #####################################
  #  initialize«parent_registration»  #
  #####################################
  
  def initialize«parent_registration»( parent_instance = self.class )

    ::ParallelAncestry.register_instance( self, parent_instance )
    
  end

end
