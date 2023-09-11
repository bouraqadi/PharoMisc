# Equals
Defines an equality method `=` that is general to apply to different applications. 
It is also easily customizable, and includes a default definition of `hash`. 
So, objects that are equal have the same hash code, and thus appear only once in hashed collections such as `Set`

# Install
```Smalltalk
Metacello new
  baseline: 'Equals';
  repository: 'github://bouraqadi/PharoMisc';
  load
```

# Usage
Simply add trait `TEquality` to the class which elements need to be equal, as in this example

```Smalltalk
Object subclass: #Fruit
	uses: TEquality
	instanceVariableNames: 'stage'
	classVariableNames: ''
	package: 'Equals-Examples'
```

By default, two objects are equal if all their instance variables (IVs) are equal.
You can override this, by overriding class method `instVarNamesForEqualityComparison` to return the subset of IVs to use for comparison.
