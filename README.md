# Parallel Ancestry #

http://rubygems.org/gems/parallel-ancestry

# Description #

Create and track parallel inheritance hierarchies. Hook parallel hierarchies (by including a module) to automatically update/register ancestry at include and extend, or update/register only manually. Manual registration permits definitions of ancestry across, for example, instances of the same type or instances of entirely different types. Used heavily by CascadingConfiguration gem (cascading-configuration) as well as by forthcoming Persistence and Magnets gems (persistence and magnets). Implementation is provided by simple child/parent trees with an block to choose which parent. This permits a simple multiple inheritance model very similar to how Ruby handles modules. Conflicts for multiple inheritance are resolved by the parent most recently named for the block match.

# Summary #

Provides parallel implementations of inheritance hierarchies. This is useful both for tracking the existing inheritance tree and for creating trees that function independently of inheritance models determined internal to Ruby.

# Install #

* sudo gem install parallel-ancestry

# Usage #

Two modules are provided by Parallel Ancestry:

1. ::ParallelAncestry, which provides parallel inheritance.
2. ::ParallelAncestry::Inheritance, which provides cascading inheritance hooks.

## ::ParallelAncestry ##

::ParallelAncestry provides parallel inheritance registration and lookup. This is useful for tracking arbitrary trees of ancestry relations (determined by manual registration), and can be combined with ::ParallelAncestry::Inheritance for automatic registration in correspondence with Ruby's inheritance relations.

3 ways to use:

1. ::ParallelAncestry provides a singleton implementation for parallel inheritance.
2. Extend any module with ::ParallelAncestry to enable module as singleton implementation for parallel inheritance.
3. Include ::ParallelAncestry in subclass of ::Module to enable instances of ::Module subclass as individual implementations for parallel inheritance.

Parallel ancestry instances support registration and lookup of arbitrarily declared ancestor relationships 

## ::ParallelAncestry::Inheritance ##

::ParallelAncestry::Inheritance provides hooks for Ruby inheritance events.

2 ways to use:

1. Extend any module with ::ParallelAncestry::Inheritance to enable hooks in module singleton.
2. Include ::ParallelAncestry::Inheritance in subclass of ::Module to enable instance of ::Module subclass wit hooks.

Hooks provided:

* Initialization

```ruby
def initialize_inheritance!
  ... [ your hook ] ...
end
```

* First include:

```ruby
def initialize_base_instance_for_include
  ... [ your hook ] ...
end
```


* First extend:

```ruby
def initialize_base_instance_for_extend
  ... [ your hook ] ...
end
```

* Subsequent includes:


```ruby
def initialize_inheriting_instance
  ... [ your hook ] ...
end
```

# License #

  (The MIT License)

  Copyright (c) Asher

  Permission is hereby granted, free of charge, to any person obtaining
  a copy of this software and associated documentation files (the
  'Software'), to deal in the Software without restriction, including
  without limitation the rights to use, copy, modify, merge, publish,
  distribute, sublicense, and/or sell copies of the Software, and to
  permit persons to whom the Software is furnished to do so, subject to
  the following conditions:

  The above copyright notice and this permission notice shall be
  included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
