
# [ BasicObject ]
basic_object_instance_parents = ::ParallelAncestry.instance_parents( ::BasicObject )
# [ Object ]
object_instance_parents       = ::ParallelAncestry.instance_parents( ::Object )
# [ Kernel ]
kernel_instance_parents       = ::ParallelAncestry.instance_parents( ::Kernel )
# [ Class ]
class_instance_parents        = ::ParallelAncestry.instance_parents( ::Class )
# [ Module ]
module_instance_parents       = ::ParallelAncestry.instance_parents( ::Module )

# [ BasicObject ]
basic_object_parents = ::ParallelAncestry.parents( ::BasicObject )
# [ Object ]
object_parents       = ::ParallelAncestry.parents( ::Object )
# [ Kernel ]
kernel_parents       = ::ParallelAncestry.parents( ::Kernel )
# [ Class ]
class_parents        = ::ParallelAncestry.parents( ::Class )
# [ Module ]
module_parents       = ::ParallelAncestry.parents( ::Module )

############################
#  Instance Bootstrapping  #
############################

  #########################
  #  instances of Object  #
  #########################
  
  # Object < BasicObject
  # [ Object, BasicObject ]
  object_instance_parents.register_parent( basic_object_instance_parents )
  # Object includes Kernel
  # [ Object, Kernel, BasicObject ]
  object_instance_parents.register_parent( kernel_instance_parents, 1 )

  #########################
  #  instances of Module  #
  #########################

  # Module < Object
  # [ Module, Object, Kernel, BasicObject ]
  module_instance_parents.register_parent( object_instance_parents )

  ########################
  #  instances of Class  #
  ########################

  # Class < Module
  # [ Class, Module, Object, Kernel, BasicObject ]
  class_instance_parents.register_parent( module_instance_parents )

#############################
#  Singleton Bootstrapping  #
#############################

  ###########
  #  Class  #
  ###########

  # Class is an instance of Class
  # [ Class, Module, Object, Kernel, BasicObject ]
  class_parents.register_parent( class_instance_parents )

  ############
  #  Object  #
  ############

  # Object is an instance of Class
  # [ Class, Module, Object, Kernel, BasicObject ]
  object_parents.register_parent( class_instance_parents )

  ############
  #  Module  #
  ############
  
  # Module is an instance of Class
  # [ Class, Module, Object, Kernel, BasicObject ]
  module_parents.register_parent( class_instance_parents )
  