# Lightweight Observer
Lightweight alternative to Announcement. Subclasses of subject automatically generate method wrappers for methods that change IVs. These wrappers take care 
of emitting events dispatched to observers. When IVs reference collections, events can be generated on accessing collection elements. 

## Install
```
Metacello new
  baseline: 'LightweightObserver';
  repository: 'github://bouraqadi/PharoMisc';
  load
```

## Usage
Subjects are typically subclasses of `LoSubject`. They inherit methods to register observers (see `LoSubject` observing protocol).

Suppose you define the following subject class.
```
LoSubject subclass: #MySubject
       instanceVariableNames: 'a b set dict collection'
       classVariableNames: ''
       package: 'MyPackage'
```

We assume that we have accesors for all IVs.

### Observe All Changes
```
|subject changeCounter|
subject := MySubject new.
changeCounter := 0.
subject afterChangeDo: [
       changeCounter := changeCounter + 1 ].
subject a: #someValue. "-> changeCounter = 1"
subject b: #otherValue. "-> changeCounter = 2"
```

### Observe Specific IV Changes
```
|subject changeCounter|
subject := MySubject new.
changeCounter := 0.
subject 
       afterChangeOf: #a 
       do: [changeCounter := changeCounter + 1 ].
subject a: #someValue. "-> changeCounter = 1"
subject b: #otherValue. "-> changeCounter = 1 (inchanged!)"
```

### Stop Observing
```
|subject changeCounter observer|
subject := MySubject new.
changeCounter := 0.
observer := subject 
                               afterChangeOf: #a 
                               do: [changeCounter := changeCounter + 1 ].
subject a: #someValue. "-> changeCounter = 1"
observer stopObserving.
subject a: #otherValue. "-> changeCounter = 1 (inchanged!)"
```

### Observe Inserting a Sequenceable Collection
```
|subject lastIndex lastRemovedValue lastInsertedValue|
subject collection: { 11. 21. 31. }.
subject 
       afterReplaceInCollection: #collection 
       do: [ : index : newValue : oldValue | 
                       lastIndex := index.
                       lastRemovedValue := newValue.
                       lastInsertedValue := oldValue].
subject collection at: 1 put: 10.
"lastIndex = 1."
"lastRemovedValue = 11."
"lastInsertedValue = 10."
```

### Observe Adding/Removing Elements to/for a Set
```
subject := LoSubjectForTest new.
subject collection: Set new.
subject 
       afterAddToCollection: #collection 
       do: [ : newValue | 
                       lastAddededValue := newValue].
subject 
       afterRemoveFromCollection: #collection 
       do: [ : newValue | 
                       lastRemovedValue := newValue].
subject collection add: 1. "-> lastAddededValue = 1"
subject collection add: 2. "-> lastAddededValue = 2"
subject collection remove: 1. "-> lastRemovedValue = 1"
subject collection remove: 2. "-> lastRemovedValue = 2"
```

### Observe Inserting a Dictionary
```
subject := LoSubjectForTest new.
subject collection: { #a->11. #b->21. #c->31. } asDictionary.
subject 
       afterReplaceInCollection: #collection 
       do: [ : key : newValue : oldValue | 
                       lastkey := key.
                       lastRemovedValue := oldValue.
                       lastInsertedValue := newValue].
subject collection at: #b put: 200.
"lastkey = #b."
"lastRemovedValue = 21."
"lastInsertedValue = 200."
```

### Subject Sending Custom Events
Custom events can be defined as subclass of `LoEvent`. They can be created whenever needed, and then dispacthed as in the following example.

Suppose we have defined the following event class.
```
LoEvent subclass: #MyEvent
       instanceVariableNames: 'data'
       classVariableNames: ''
       package: 'MyPackage'
```

We assume we accessors for the `data` IV.

```
|subject observedData newEvent|
subject := MySubject new.
subject 
       on: MyEvent 
       do: [: event | observedData := event data ].
newEvent := MyEvent new.
newEvent data: 123.
subject dispatch: newEvent. "-> observedData = 123."
