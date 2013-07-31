# -*- encoding : utf-8 -*-

require_relative '../lib/parallel_ancestry.rb'

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
  
  let( :parallel_ancestry ) { ::ParallelAncestry }
  
  context '================  Bootstrapping  ================' do

    context 'BasicObject bootstrapping' do
      it 'is bootstrapped for singleton parents that inherit from Class instance parents' do
        parallel_ancestry.parents( BasicObject ).should == [ Class, Module, Object, Kernel, BasicObject ]
      end
      it 'is bootstrapped for instance parents [ BasicObject ]' do
        parallel_ancestry.instance_parents( BasicObject ).should == [ BasicObject ]
      end
    end

    context 'Kernel bootstrapping' do
      it 'is bootstrapped for singleton parents that inherit from Module instance parents' do
        parallel_ancestry.parents( Kernel ).should == [ Module, Object, Kernel, BasicObject ]
      end
      it 'is bootstrapped for instance parents [ Kernel ]' do
        parallel_ancestry.instance_parents( Kernel ).should == [ Kernel ]
      end
    end

    context 'Object bootstrapping' do
      it 'is bootstrapped for singleton parents that inherit from Class instance parents' do
        parallel_ancestry.parents( Object ).should == [ Class, Module, Object, Kernel, BasicObject ]
      end
      it 'is bootstrapped for instance parents [ Object, Kernel, BasicObject ]' do
        parallel_ancestry.instance_parents( Object ).should == [ Object, Kernel, BasicObject ]
      end
    end

    context 'Class bootstrapping' do
      it 'is bootstrapped for singleton parents that inherit from Class instance parents' do
        parallel_ancestry.parents( Class ).should == [ Class, Module, Object, Kernel, BasicObject ]
      end
      it 'is bootstrapped for instance parents [ Class, Module, Object, Kernel, BasicObject ]' do
        parallel_ancestry.instance_parents( Class ).should == [ Class, Module, Object, Kernel, BasicObject ]
      end
    end
  
    context 'Module bootstrapping' do
      it 'is bootstrapped for singleton parents that inherit from Class instance parents' do
        parallel_ancestry.parents( Module ).should == [ Class, Module, Object, Kernel, BasicObject ]
      end
      it 'is bootstrapped for instance parents [ Class, Module, Object, Kernel, BasicObject ]' do
        parallel_ancestry.instance_parents( Module ).should == [ Module, Object, Kernel, BasicObject ]
      end
    end
    
  end

  context '================  General Purpose  ================' do

    let( :instance_of_object ) { ::Object.new }

    let( :class_instance ) { parallel_ancestry::MockClass }
    let( :instance_of_class ) { parallel_ancestry::MockClass.new }

    let( :subclass ) { parallel_ancestry::MockSubclass }
    let( :instance_of_subclass ) { parallel_ancestry::MockSubclass.new }

    let( :module_instance ) { parallel_ancestry::MockModule }
    let( :module_extended_by_module ) { parallel_ancestry::MockModuleExtendedByModule }
    let( :module_including_module ) { parallel_ancestry::MockModuleIncludingModule }
    let( :class_extended_by_module ) { parallel_ancestry::MockClassExtendedByModule }
    let( :class_including_module ) { parallel_ancestry::MockClassIncludingModule }

    let( :module_class ) { parallel_ancestry::MockModuleClass }
    let( :instance_of_module_class ) { parallel_ancestry::InstanceOfMockModuleClass }
    let( :module_extended_by_instance_of_module_class ) { parallel_ancestry::MockModuleExtendedByInstanceOfModuleClass }
    let( :module_including_instance_of_module_class ) { parallel_ancestry::MockModuleIncludingInstanceOfModuleClass }
    let( :class_extended_by_instance_of_module_class ) { parallel_ancestry::MockClassExtendedByInstanceOfModuleClass }
    let( :class_including_instance_of_module_class ) { parallel_ancestry::MockClassIncludingInstanceOfModuleClass }

    let( :module_subclass ) { parallel_ancestry::MockModuleSubclass }
    let( :instance_of_module_subclass ) { parallel_ancestry::InstanceOfMockModuleSubclass }
    let( :module_extended_by_instance_of_module_subclass ) { parallel_ancestry::MockModuleExtendedByInstanceOfModuleSubclass }
    let( :module_including_instance_of_module_subclass ) { parallel_ancestry::MockModuleIncludingInstanceOfModuleSubclass }
    let( :class_extended_by_instance_of_module_subclass ) { parallel_ancestry::MockClassExtendedByInstanceOfModuleSubclass }
    let( :class_including_instance_of_module_subclass ) { parallel_ancestry::MockClassIncludingInstanceOfModuleSubclass }

    context 'class instance (ie. SomeClass)' do
      it 'singleton parents are [ MockClass, Class, Module, Object, Kernel, BasicObject ]' do
        parallel_ancestry.parents( class_instance ).should == [ class_instance, Class, Module, Object, Kernel, BasicObject ]
      end
      it 'instance parents are [ MockClass, Object, Class, Module, Object, Kernel, BasicObject ]' do
        parallel_ancestry.instance_parents( class_instance ).should == [ class_instance, Object, Class, Module, Object, Kernel, BasicObject ]
      end
    end

    context 'instance of class instance (ie <#SomeClass>)' do
      it 'singleton parents are [ self, MockClass, Class, Module, Object, Kernel, BasicObject ]' do
        parallel_ancestry.parents( instance_of_class ).should == [ instance_of_class, class_instance, Class, Module, Object, Kernel, BasicObject ]
      end
      it 'instance parents are the same as singleton parents' do
        parallel_ancestry.instance_parents( instance_of_class ).should be parallel_ancestry.parents( instance_of_class )
      end
    end

    context 'subclass' do
      it 'singleton parents are [ MockSubclass, MockClass, Class, Module, Object, Kernel, BasicObject ]' do
        parallel_ancestry.parents( subclass ).should == [ subclass, class_instance, Class, Module, Object, Kernel, BasicObject ]
      end
      it 'instance parents are [ MockSubclass, MockClass, Object, Class, Module, Object, Kernel, BasicObject ]' do
        parallel_ancestry.instance_parents( subclass ).should == [ subclass, class_instance, Object, Class, Module, Object, Kernel, BasicObject ]
      end
    end

    context 'instance of subclass' do
      it 'singleton parents are [ MockSubclass, MockClass, Class, Module, Object, Kernel, BasicObject ]' do
        parallel_ancestry.parents( instance_of_subclass ).should == [ instance_of_subclass, subclass, class_instance, Class, Module, Object, Kernel, BasicObject ]
      end
      it 'instance parents are the same as singleton parents' do
        parallel_ancestry.instance_parents( instance_of_subclass ).should be parallel_ancestry.parents( instance_of_subclass )
      end
    end

    context 'module' do
      it 'singleton parents are [ Module, Object, Kernel, BasicObject ]' do
        parallel_ancestry.parents( module_instance ).should == [ Module, Object, Kernel, BasicObject ]
      end
      it 'instance parents are [ MockClass, Object, Class, Module, Object, Kernel, BasicObject ]' do
        parallel_ancestry.instance_parents( module_instance ).should == [ class_instance, Object, Class, Module, Object, Kernel, BasicObject ]
      end
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
      it 'singleton parents are [ MockModuleClass, Class, Module, Object, Kernel, BasicObject ]' do
        parallel_ancestry.parents( class_instance ).should == [ parallel_ancestry::MockSubclass, parallel_ancestry::MockModuleSubclass, Class, Module, Object, Kernel, BasicObject ]
      end
      it 'instance parents are [ MockModuleClass, Object, Class, Module, Object, Kernel, BasicObject ]' do
        parallel_ancestry.instance_parents( class_instance ).should == [ parallel_ancestry::MockSubclass, parallel_ancestry::MockModuleSubclass, Object, Class, Module, Object, Kernel, BasicObject ]
      end
    end

    context 'instance of class < Module' do
    end

    context 'instance of class extended by instance of class < Module' do
    end

    context 'instance of subclass extended by instance of class < Module' do
    end

    context 'subclass of class < Module' do
      it 'singleton parents are [ MockModuleSubclass, MockModuleClass, Class, Module, Object, Kernel, BasicObject ]' do
        parallel_ancestry.parents( class_instance ).should == [ parallel_ancestry::MockModuleSubclass, parallel_ancestry::MockModuleClass, Class, Module, Object, Kernel, BasicObject ]
      end
      it 'instance parents are [ MockModuleSubclass, MockModuleClass, Object, Class, Module, Object, Kernel, BasicObject ]' do
        parallel_ancestry.instance_parents( class_instance ).should == [ parallel_ancestry::MockModuleSubclass, parallel_ancestry::MockModuleClass, Object, Class, Module, Object, Kernel, BasicObject ]
      end
    end

    context 'instance of subclass of class < Module' do
    end

    context 'instance of class extended by instance of subclass of class < Module' do
    end

    context 'instance of subclass extended by instance of subclass of class < Module' do
    end

  end

end
