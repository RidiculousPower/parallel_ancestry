# -*- encoding : utf-8 -*-

###
# Extends ParallelAncestry singleton for tracking objects
#
module ::ParallelAncestry::Common::Ancestors

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
  # @return [Array::UniqueByID::Compositing] 
  #
  #         Struct for instance.
  #
  def parents( instance, create_if_needed = true, register_self = true )
    
    unless parents_array = @parents_hash[ instance_id = instance.__id__ ] or 
           ! create_if_needed
      
      @parents_hash[ instance_id ] = parents_array = ::Array::UniqueByID::Compositing.new( nil, instance )

      # Insert self in order
      parents_array.push( instance ) if register_self

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
  # @return [Array::UniqueByID::Compositing] 
  #
  #         Struct for instance.
  #
  def instance_parents( instance, create_if_needed = true )
    
    parents_array = nil
    
    case instance

      when ::Module
        
        unless parents_array = @instance_parents_hash[ instance_id = instance.__id__ ] or 
               ! create_if_needed

          @instance_parents_hash[ instance_id ] = parents_array = ::Array::UniqueByID::Compositing.new( nil, instance )

          # Insert self in order
          parents_array.push( instance )

        end        

      else

        parents_array = parents( instance, create_if_needed )
        
    end    

    return parents_array
    
  end

  #####################
  #  register_parent  #
  #####################
  
  ###
  # Register instance as child of another instance.
  #
  # @param [Object] instance 
  #
  #        Instance for which parent is being registered.
  #
  # @param [Object] parent 
  #
  #        Parent instance.
  #
  # @return Self.
  #
  def register_parent( instance, parent )

    parents( instance ).register_parent( parent, 1 )
    
    return self

  end


  #######################
  #  unregister_parent  #
  #######################
  
  ###
  # Unregister instance as child of another instance.
  #
  # @param [Object] instance 
  #
  #        Instance for which parent is being registered.
  #
  # @param [Object] parent 
  #
  #        Parent instance.
  #
  # @return Self.
  #
  def unregister_parent( instance, parent )

    if parents = parents( instance, false )
      parents.unregister_parent( parent )
    end
    
    return self

  end

  ##############################
  #  register_instance_parent  #
  ##############################
  
  ###
  # Register instance as child of another instance.
  #
  # @param [Object] instance 
  #
  #        Instance for which parent is being registered.
  #
  # @param [Object] parent 
  #
  #        Parent instance.
  #
  # @return Self.
  #
  def register_instance_parent( instance, parent )

    instance_parents( instance ).register_parent( parent, 1 )

    return self

  end


  ################################
  #  unregister_instance_parent  #
  ################################
  
  ###
  # Unregister instance as child of another instance.
  #
  # @param [Object] instance 
  #
  #        Instance for which parent is being registered.
  #
  # @param [Object] parent 
  #
  #        Parent instance.
  #
  # @return Self.
  #
  def unregister_instance_parent( instance, parent )

    if parents = instance_parents( instance, false )
      parents.unregister_parent( parent )
    end
    
    return self

  end

  ###############
  #  is_child?  #
  ###############
  
  def is_child?( instance, potential_parent  )
    
    is_child = false
    
    if parents = parents( instance, false ) and
       parent.include?( potential_parent )

      is_child = true

    end
    
    return is_child
    
  end
  
end
