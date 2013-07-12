# -*- encoding : utf-8 -*-

module ::ParallelAncestry::Ancestors

  ###################
  #  self.extended  #
  ###################

  def self.extended( instance )
    
    instance.instance_eval do
      @parents_hash ||= { }
      @instance_parents_hash ||= { }
    end
    
  end

  #############
  #  parents  #
  #############
  
  ###
  # Retrieve parents Array for instance.
  #
  # @param [Object] instance 
  #
  #        Child instance.
  #
  # @return [ParallelAncestry::Array::UniqueByID] 
  #
  #         Struct for instance.
  #
  def parents( instance )

    unless parents_array = @parents_hash[ instance_id = instance.__id__ ]
      
      @parents_hash[ instance_id ] = parents_array = self::Array::UniqueByID.new

      # Insert self in order
      parents_array.push( instance )

      # Most objects will register by hook. 
      # This is true for:
      # * class instances
      # * instances of classes inheriting from Module
      # * instances of classes inheriting from Object
      # This is not true for:
      # * instances of Module created by parser 
      if instance.class.equal?( ::Module )
        module_parents = parents( ::Module )
        parents_array.register_parent( module_parents, 0 )
      end

    end

    return parents_array
    
  end
  
  ######################
  #  instance_parents  #
  ######################
  
  ###
  # Retrieve parents Array for instance.
  #
  # @param [Object] instance 
  #
  #        Child instance.
  #
  # @return [ParallelAncestry::Array::UniqueByID] 
  #
  #         Struct for instance.
  #
  def instance_parents( instance )

    unless instance_parents_array = @instance_parents_hash[ instance_id = instance.__id__ ]

      @instance_parents_hash[ instance_id ] = instance_parents_array = self::Array::UniqueByID.new

      # Insert self in order
      instance_parents_array.push( instance )

      # Most objects will register by hook. 
      # This is true for:
      # * class instances
      # * instances of classes inheriting from Module
      # * instances of classes inheriting from Object
      # This is not true for:
      # * instances of Module created by parser 
      if instance.class.equal?( ::Module )
        module_parents = instance_parents( ::Module )
        instance_parents_array.register_parent( module_parents )
      end

    end

    return instance_parents_array
    
  end
  
  #######################
  #  register_subclass  #
  #######################
  
  def register_subclass( subclass, superclass )
  end

  ######################
  #  register_include  #
  ######################

  def register_include( class_or_module, including_module )
  end

  #####################
  #  register_extend  #
  #####################

  def register_extend( instance, extending_module )
  end

  #######################
  #  register_instance  #
  #######################

  def register_instance( instance, parent_instance )
  end

end
