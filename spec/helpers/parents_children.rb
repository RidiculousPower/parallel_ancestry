
########################
#  be_instance_parent  #
########################

RSpec::Matchers.define :be_instance_parent do |instance|

  unexpected_success_string = nil
  fail_string = nil

  match do |potential_parent|
    
    matched = nil
    
    unexpected_success_string = potential_parent.to_s << ' was determined to be an instance parent of ' << instance.to_s << 
                                ', ' << 'but was not expected to be.'

    unless matched = ::ParallelAncestry.is_instance_parent?( instance, potential_parent )
      fail_string = instance.to_s << ' was not an instance parent of ' << potential_parent.to_s << '.'
    end

    matched
    
  end

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

#######################
#  be_instance_child  #
#######################

RSpec::Matchers.define :be_instance_child do |instance|

  unexpected_success_string = nil
  fail_string = nil

  match do |potential_child|
    
    matched = nil

    unexpected_success_string = potential_child.to_s << ' was determined to be an instance child of ' << instance.to_s << 
                                ', ' << 'but was not expected to be.'

    unless matched = ::ParallelAncestry.is_instance_child?( instance, potential_child )
      fail_string = instance.to_s << ' was not an instance child of ' << potential_child.to_s << '.'
    end

    matched
    
  end

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

#########################
#  be_singleton_parent  #
#########################

RSpec::Matchers.define :be_singleton_parent do |instance|

  unexpected_success_string = nil
  fail_string = nil

  match do |potential_parent|
    
    matched = nil
    
    unexpected_success_string = potential_parent.to_s << ' was determined to be a singleton parent of ' << 
                                instance.to_s << ', ' << 'but was not expected to be.'

    unless matched = ::ParallelAncestry.is_singleton_parent?( instance, potential_parent )
      fail_string = instance.to_s << ' was not a singleton parent of ' << potential_parent.to_s << '.'
    end

    matched
    
  end

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end

########################
#  be_singleton_child  #
########################

RSpec::Matchers.define :be_singleton_child do |instance|

  unexpected_success_string = nil
  fail_string = nil

  match do |potential_child|
    
    matched = nil
    
    unexpected_success_string = potential_child.to_s << ' was determined to be a singleton child of ' << 
                                instance.to_s << ', ' << 'but was not expected to be.'

    unless matched = ::ParallelAncestry.is_singleton_child?( instance, potential_child )
      fail_string = instance.to_s << ' was not a singleton child of ' << potential_child.to_s << '.'
    end

    matched
    
  end

  failure_message_for_should { fail_string }
  failure_message_for_should_not { unexpected_success_string }

end
