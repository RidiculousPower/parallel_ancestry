# -*- encoding : utf-8 -*-

require_relative '../lib/parallel_ancestry.rb'
require_relative 'helpers/parents_children.rb'

class ::ParallelAncestry::MockClass
end
class ::ParallelAncestry::MockSubclass < ::ParallelAncestry::MockClass
end

module ::ParallelAncestry::MockModule
end
module ::ParallelAncestry::MockModuleIncludingModule
  include ::ParallelAncestry::MockModule
end
module ::ParallelAncestry::MockModuleExtendedByModule
  extend ::ParallelAncestry::MockModule
end
class ::ParallelAncestry::MockClassIncludingModule
  include ::ParallelAncestry::MockModule
end
class ::ParallelAncestry::MockClassExtendedByModule
  extend ::ParallelAncestry::MockModule
end

class ::ParallelAncestry::MockModuleClass < ::Module
end
::ParallelAncestry::InstanceOfMockModuleClass = ::ParallelAncestry::MockModuleClass.new
module ::ParallelAncestry::MockModuleIncludingInstanceOfModuleClass
  include ::ParallelAncestry::InstanceOfMockModuleClass
end
module ::ParallelAncestry::MockModuleExtendedByInstanceOfModuleClass
  extend ::ParallelAncestry::InstanceOfMockModuleClass
end
class ::ParallelAncestry::MockClassIncludingInstanceOfModuleClass
  include ::ParallelAncestry::InstanceOfMockModuleClass
end
class ::ParallelAncestry::MockClassExtendedByInstanceOfModuleClass
  extend ::ParallelAncestry::InstanceOfMockModuleClass
end

class ::ParallelAncestry::MockModuleSubclass < ::ParallelAncestry::MockModuleClass
end
::ParallelAncestry::InstanceOfMockModuleSubclass = ::ParallelAncestry::MockModuleSubclass.new
module ::ParallelAncestry::MockModuleIncludingInstanceOfModuleSubclass
  include ::ParallelAncestry::InstanceOfMockModuleSubclass
end
module ::ParallelAncestry::MockModuleExtendedByInstanceOfModuleSubclass
  extend ::ParallelAncestry::InstanceOfMockModuleSubclass
end
class ::ParallelAncestry::MockClassIncludingInstanceOfModuleSubclass
  include ::ParallelAncestry::InstanceOfMockModuleSubclass
end
class ::ParallelAncestry::MockClassExtendedByInstanceOfModuleSubclass
  extend ::ParallelAncestry::InstanceOfMockModuleSubclass
end

describe ::ParallelAncestry do

  let( :instance_of_object ) { ::Object.new }
  
  let( :class_instance ) { ::ParallelAncestry::MockClass }
  let( :instance_of_class ) { ::ParallelAncestry::MockClass.new }
  
  let( :subclass ) { ::ParallelAncestry::MockSubclass }
  let( :instance_of_subclass ) { ::ParallelAncestry::MockSubclass.new }
  
  let( :module_instance ) { ::ParallelAncestry::MockModule }
  let( :module_extended_by_module ) { ::ParallelAncestry::MockModuleExtendedByModule }
  let( :module_including_module ) { ::ParallelAncestry::MockModuleIncludingModule }
  let( :class_extended_by_module ) { ::ParallelAncestry::MockClassExtendedByModule }
  let( :class_including_module ) { ::ParallelAncestry::MockClassIncludingModule }
  
  let( :module_class ) { ::ParallelAncestry::MockModuleClass }
  let( :instance_of_module_class ) { ::ParallelAncestry::InstanceOfMockModuleClass }
  let( :module_extended_by_instance_of_module_class ) { ::ParallelAncestry::MockModuleExtendedByInstanceOfModuleClass }
  let( :module_including_instance_of_module_class ) { ::ParallelAncestry::MockModuleIncludingInstanceOfModuleClass }
  let( :class_extended_by_instance_of_module_class ) { ::ParallelAncestry::MockClassExtendedByInstanceOfModuleClass }
  let( :class_including_instance_of_module_class ) { ::ParallelAncestry::MockClassIncludingInstanceOfModuleClass }
  
  let( :module_subclass ) { ::ParallelAncestry::MockModuleSubclass }
  let( :instance_of_module_subclass ) { ::ParallelAncestry::InstanceOfMockModuleSubclass }
  let( :module_extended_by_instance_of_module_subclass ) { ::ParallelAncestry::MockModuleExtendedByInstanceOfModuleSubclass }
  let( :module_including_instance_of_module_subclass ) { ::ParallelAncestry::MockModuleIncludingInstanceOfModuleSubclass }
  let( :class_extended_by_instance_of_module_subclass ) { ::ParallelAncestry::MockClassExtendedByInstanceOfModuleSubclass }
  let( :class_including_instance_of_module_subclass ) { ::ParallelAncestry::MockClassIncludingInstanceOfModuleSubclass }

  context 'Class' do
    it 'does not have Object as an instance parent (to avoid loops), even though properly speaking Class is an Object instance' do
      ::Object.should_not be_instance_parent( ::Class )
    end
    it 'does not have Object as a singleton parent' do
      ::Object.should_not be_singleton_parent( ::Class )
    end
    it 'does not have Module as an instance parent (to avoid loops), even though properly speaking Class is an Module instance' do
      ::Module.should_not be_instance_parent( ::Class )
    end
    it 'does not have Module as a singleton parent' do
      ::Module.should_not be_singleton_parent( ::Class )
    end
    it 'has Object as an instance child' do
      ::Object.should be_instance_child( ::Class )
    end
    it 'does not have Object as an singleton child' do
      ::Object.should_not be_singleton_child( ::Class )
    end
    it 'has Module as an instance child' do
      ::Module.should be_instance_child( ::Class )
    end
    it 'does not have Module as an singleton child' do
      ::Module.should_not be_singleton_child( ::Class )
    end
    it 'does not have instances of Object as a singleton child' do
      instance_of_object.should_not be_singleton_child( ::Class )
    end
    it 'does not have instances of Object as an instance child' do
      instance_of_object.should_not be_instance_child( ::Class )
    end
  end
  
  context 'Object' do
    it 'has Class as an instance parent' do
      ::Class.should be_instance_parent( ::Object )
    end
    it 'does not have Class as a singleton parent' do
      ::Class.should_not be_singleton_parent( ::Object )
    end
    it 'does not have Module as an instance parent (to avoid loops), even though properly speaking any Class instance is a Module instance' do
      ::Module.should_not be_instance_parent( ::Object )
    end
    it 'does not have Module as a singleton parent (to avoid loops), even though properly speaking any Class instance is a Module instance' do
      ::Module.should_not be_singleton_parent( ::Object )
    end
    it 'has Module as a singleton child' do
      ::Module.should be_singleton_child( ::Object )
    end
    it 'has Module as an instance child' do
      ::Module.should be_instance_child( ::Object )
    end
    it 'does not have instances of Object as a singleton child' do
      instance_of_object.should_not be_singleton_child( ::Object )
    end
    it 'has instances of Object as an instance child' do
      instance_of_object.should be_instance_child( ::Object )
    end
  end

  context 'Module' do
    it 'has Class as an instance parent' do
      ::Class.should be_instance_parent( ::Module )
    end
    it 'does not have Class as a singleton parent' do
      ::Class.should_not be_singleton_parent( ::Module )
    end
    it 'has Object as an instance parent' do
      ::Object.should be_instance_parent( ::Module )
    end
    it 'has Object as a singleton parent' do
      ::Object.should be_singleton_parent( ::Module )
    end
    it 'does not have instances of Object as a singleton child' do
      instance_of_object.should_not be_singleton_child( ::Module )
    end
    it 'does not have instances of Object as an instance child' do
      instance_of_object.should_not be_instance_child( ::Module )
    end
  end

  context 'class' do
    it 'has Object as singleton parent' do
      ::Object.should be_singleton_parent( class_instance )
    end
    it 'has Object as instance parent' do
      ::Object.should be_instance_parent( class_instance )
    end
    it 'has Class as instance parent' do
      ::Class.should be_instance_parent( class_instance )
    end
    it 'does not have Class as singleton parent' do
      ::Class.should_not be_singleton_parent( class_instance )
    end
    it 'does not have Module as singleton parent' do
      ::Module.should_not be_singleton_parent( class_instance )
    end
    it 'does not have Module as instance parent (even though in Ruby a class is a module)' do
      ::Module.should_not be_instance_parent( class_instance )
    end
    it 'does not have instances of Object as a singleton child' do
      instance_of_object.should_not be_singleton_child( class_instance )
    end
    it 'does not have instances of Object as an instance child' do
      instance_of_object.should_not be_instance_child( class_instance )
    end
  end

  context 'instance of class' do
    it 'does not have Class as instance parent' do
      ::Class.should_not be_instance_parent( instance_of_class )
    end
    it 'does not have Class as singleton parent' do
      ::Class.should_not be_singleton_parent( instance_of_class )
    end
    it 'has Object as instance parent' do
      ::Object.should be_instance_parent( instance_of_class )
    end
    it 'does not have Object as singleton parent' do
      ::Object.should_not be_singleton_parent( instance_of_class )
    end
    it 'does not have Module as instance parent' do
      ::Module.should_not be_instance_parent( instance_of_class )
    end
    it 'does not have Module as singleton parent' do
      ::Module.should_not be_singleton_parent( instance_of_class )
    end
    it 'has its class as instance parent' do
      class_instance.should be_instance_parent( instance_of_class )
    end
    it 'does not have its class as singleton parent' do
      class_instance.should_not be_singleton_parent( instance_of_class )
    end
  end
  
  context 'subclass' do
    it 'has Object as singleton parent' do
      ::Object.should be_singleton_parent( subclass )
    end
    it 'has Object as instance parent' do
      ::Object.should be_instance_parent( subclass )
    end
    it 'has Class as instance parent' do
      ::Class.should be_instance_parent( subclass )
    end
    it 'does not have Class as singleton parent' do
      ::Class.should_not be_singleton_parent( subclass )
    end
    it 'does not have Module as singleton parent' do
      ::Module.should_not be_singleton_parent( subclass )
    end
    it 'does not have Module as instance parent (even though in Ruby a class is a module)' do
      ::Module.should_not be_instance_parent( subclass )
    end
    it 'does not have instances of Object as a singleton child' do
      class_instance.should_not be_singleton_child( subclass )
    end
    it 'does not have instances of Object as an instance child' do
      class_instance.should_not be_instance_child( subclass )
    end
  end
  
  context 'instance of subclass' do
  end

  context 'module' do
  end
  
  context 'module extended by module' do
  end
  
  context 'module including module' do
  end
  
  context 'class extended by module' do
  end
  
  context 'class including module' do
  end

  context 'instance of class extended by module' do
  end

  context 'instance of subclass extended by module' do
  end
  
  context 'class < Module' do
  end

  context 'instance of class < Module' do
  end

  context 'instance of class extended by instance of class < Module' do
  end

  context 'instance of subclass extended by instance of class < Module' do
  end
  
  context 'subclass of class < Module' do
  end 
  
  context 'instance of subclass of class < Module' do
  end

  context 'instance of class extended by instance of subclass of class < Module' do
  end

  context 'instance of subclass extended by instance of subclass of class < Module' do
  end

end
