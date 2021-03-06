
## 6/10/2012 ##

Initial release abstracted to be entirely independent from cascading-configuration.
Replaces cascading-configuration-inheritance and cascading-configuration-ancestors without any cascading-configuration dependencies.

## 6/11/2012 ##

Added YARD docs.
Shortened :initialize_base_instance_for_include and :initialize_base_instance_for_extend parameters to remove reference to self, since self is already present as block receiver.

## 6/12/2012 ##

Renamed :match_ancestor_searching_upward to :match_ancestor because ancestors are always found by searching upward.
Fixes for ancestor lookup when arriving at Class.

## 6/15/2012 ##

Added unique-array for children and parents, which means now :include? etc. use hash lookup internally.

## 6/18/2012 ##

Added is_extending parameter (default = false) to :initialize_inheriting_instance.
Fix for subclass inheritance passing subclass instance (self) rather than class instance.

## 6/19/2012 ##

Changed include/extend hooks to prepend.

## 7/06/2012 ##

Renamed to parallel_ancestry.

## 7/10/2012 ##

Fixes for which instances blocks are eval'd on.