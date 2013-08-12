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

  ####################
  #  create_parents  #
  ####################
  
  def create_parents( instance )
    
    return @parents_hash[ instance.__id__ ] = ::ParallelAncestry::ParentsArray.new( nil, instance )
    
  end
  
  #############################
  #  create_instance_parents  #
  #############################
  
  def create_instance_parents( instance )
    
    return @instance_parents_hash[ instance.__id__ ] = ::ParallelAncestry::InstanceParentsArray.new( nil, instance )
    
  end
  
  ###############
  #  bootstrap  #
  ###############
  
  def bootstrap
    
    #--------------------------#
    #  Instance Bootstrapping  #
    #--------------------------#

      # [ BasicObject ]
      basic_object_instance_parents = create_instance_parents( ::BasicObject )
      basic_object_instance_parents.push( ::BasicObject )
      # [ Object ]
      object_instance_parents       = create_instance_parents( ::Object )
      object_instance_parents.push( ::Object )
      # [ Kernel ]
      kernel_instance_parents       = create_instance_parents( ::Kernel )
      kernel_instance_parents.push( ::Kernel )
      # [ Class ]
      class_instance_parents        = create_instance_parents( ::Class )
      class_instance_parents.push( ::Class )
      # [ Module ]
      module_instance_parents       = create_instance_parents( ::Module )
      module_instance_parents.push( ::Module )

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
      basic_object_parents = create_parents( ::BasicObject )
      # [ Object ]
      object_parents       = create_parents( ::Object )
      # [ Kernel ]
      kernel_parents       = create_parents( ::Kernel )
      # [ Class ]
      class_parents        = create_parents( ::Class )
      class_parents.push( ::Class )
      # [ Module ]
      module_parents       = create_parents( ::Module )

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

