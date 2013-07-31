# -*- encoding : utf-8 -*-

###
# Extends ParallelAncestry singleton to bootstrap ancestor hierarchy.
#
module ::ParallelAncestry::Common::Bootstrap
  
  ###################
  #  self.extended  #
  ###################

  def self.extended( instance )
    
    instance.bootstrap
    
  end
  
  ###############
  #  bootstrap  #
  ###############
  
  def bootstrap
    
    #--------------------------#
    #  Instance Bootstrapping  #
    #--------------------------#

      # [ BasicObject ]
      basic_object_instance_parents = instance_parents( ::BasicObject )
      # [ Object ]
      object_instance_parents       = instance_parents( ::Object )
      # [ Kernel ]
      kernel_instance_parents       = instance_parents( ::Kernel, true )
      # [ Class ]
      class_instance_parents        = instance_parents( ::Class )
      # [ Module ]
      module_instance_parents       = instance_parents( ::Module )

      #-----------------------#
      #  instances of Object  #
      #-----------------------#
  
      # Object < BasicObject
      # [ Object, BasicObject ]
      object_instance_parents.register_parent( basic_object_instance_parents )
      # Object includes Kernel
      # [ Object, Kernel, BasicObject ]
      object_instance_parents.register_parent( kernel_instance_parents, 1 )

      #-----------------------#
      #  instances of Module  #
      #-----------------------#

      # Module < Object
      # [ Module, Object, Kernel, BasicObject ]
      module_instance_parents.register_parent( object_instance_parents )

      #----------------------#
      #  instances of Class  #
      #----------------------#

      # Class < Module
      # [ Class, Module, Object, Kernel, BasicObject ]
      class_instance_parents.register_parent( module_instance_parents )

    #---------------------------#
    #  Singleton Bootstrapping  #
    #---------------------------#

      # [ BasicObject ]
      basic_object_parents = parents( ::BasicObject, true, false )
      # [ Object ]
      object_parents       = parents( ::Object, true, false )
      # [ Kernel ]
      kernel_parents       = parents( ::Kernel, true, false )
      # [ Class ]
      class_parents        = parents( ::Class )
      # [ Module ]
      module_parents       = parents( ::Module, true, false )

      #---------#
      #  Class  #
      #---------#

      # Class is an instance of Class
      # [ Class, Module, Object, Kernel, BasicObject ]
      class_parents.register_parent( class_instance_parents )

      #---------------#
      #  BasicObject  #
      #---------------#
      
      # BasicObject is an instance of Class
      # [ Class, Module, Object, Kernel, BasicObject ]
      basic_object_parents.register_parent( class_instance_parents )

      #----------#
      #  Object  #
      #----------#

      # Object is an instance of Class
      # [ Class, Module, Object, Kernel, BasicObject ]
      object_parents.register_parent( class_instance_parents )

      #----------#
      #  Module  #
      #----------#
  
      # Module is an instance of Class
      # [ Class, Module, Object, Kernel, BasicObject ]
      module_parents.register_parent( class_instance_parents )

      #----------#
      #  Kernel  #
      #----------#

      kernel_parents.register_parent( module_instance_parents )

  end
  
end