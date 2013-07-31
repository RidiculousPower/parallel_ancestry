# -*- encoding : utf-8 -*-

###
# Extends ParallelAncestry singleton for tracking objects
#
module ::ParallelAncestry::Common::Parents

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
  def parents( instance, create_if_needed = true )
    
    unless parents_array = @parents_hash[ instance.__id__ ] or ! create_if_needed
      parents_array = create_parents( instance )
      # Insert self in order
      parents_array.push( instance )
      case instance
        when ::Module
          if instance.class.equal?( ::Module )
            parents_array.register_parent( instance_parents( ::Module ), 1 )
          end
        else
          parents_array.register_parent( instance_parents( instance.class ), 1 )
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
  # @return [Array::UniqueByID::Compositing] 
  #
  #         Struct for instance.
  #
  def instance_parents( instance, create_if_needed = true )
    
    parents_array = nil
    
    case instance

      when ::Module
        
        unless parents_array = @instance_parents_hash[ instance.__id__ ] or ! create_if_needed
          parents_array = create_instance_parents( instance )
          # Insert self in order
          parents_array.push( instance )
        end        

      else

        parents_array = parents( instance, create_if_needed )
        
    end    

    return parents_array
    
  end

  ################
  #  is_parent?  #
  ################
  
  def is_parent?( instance, potential_parent  )
    
    is_parent = false
    
    if parents = parents( instance, false ) and
       parent.include?( potential_parent )

      is_parent = true

    end
    
    return is_parent
    
  end

  #########################
  #  is_instance_parent?  #
  #########################
  
  def is_instance_parent?( instance, potential_parent  )
    
    is_parent = false
    
    if parents = instance_parents( instance, false ) and
       parent.include?( potential_parent )

      is_parent = true

    end
    
    return is_parent
    
  end

end
