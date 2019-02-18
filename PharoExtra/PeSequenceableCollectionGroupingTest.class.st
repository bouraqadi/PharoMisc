Class {
	#name : #PeSequenceableCollectionGroupingTest,
	#superclass : #TestCase,
	#category : #'PharoExtra-Collections'
}

{ #category : #testing }
PeSequenceableCollectionGroupingTest >> assertGroupCount: expectedGroupCount of: collection groupSize: groupSize [
	| actualGroupCount |
	actualGroupCount := 0.
	collection groupsOfAtMost: groupSize atATimeDo: [ actualGroupCount := actualGroupCount + 1 ].
	self assert: actualGroupCount equals: expectedGroupCount.

]

{ #category : #testing }
PeSequenceableCollectionGroupingTest >> assertGroupElements: expectedGroups of: collection groupSize: groupSize [
	| actualGroups |
	actualGroups := OrderedCollection new.
	collection groupsOfAtMost: groupSize atATimeCollect: [: aGroup | actualGroups add: aGroup].
	self assert: actualGroups size equals: expectedGroups size.
	actualGroups 
		with: expectedGroups
		do: [ : actual : expected |
			self assertCollection: actual equals: expected  ]
]

{ #category : #testing }
PeSequenceableCollectionGroupingTest >> testGroupCount [
	self assertGroupCount: 0 of: #() groupSize: 1.
	self assertGroupCount: 1 of: #(a) groupSize: 1.
	self assertGroupCount: 10 of: (1 to: 10) groupSize: 1.

	self assertGroupCount: 0 of: #() groupSize: 2.
	self assertGroupCount: 1 of: #(a) groupSize: 2.
	self assertGroupCount: 1 of: #(a b) groupSize: 2.
	self assertGroupCount: 5 of: (1 to: 10) groupSize: 2.
	
	self assertGroupCount: 0 of: #() groupSize: 3.
	self assertGroupCount: 1 of: #(a) groupSize: 3.
	self assertGroupCount: 1 of: #(a b) groupSize: 3.
	self assertGroupCount: 1 of: #(a b c) groupSize: 3.
	self assertGroupCount: 2 of: #(a b c d) groupSize: 3.
	self assertGroupCount: 4 of: (1 to: 10) groupSize: 3.

]

{ #category : #testing }
PeSequenceableCollectionGroupingTest >> testGroupElements [
	self assertGroupElements: #() of: #() groupSize: 1.
	self assertGroupElements: #(#(a)) of: #(a) groupSize: 1.
	self assertGroupElements: #(#(a) #(b) #(c)) of: #(a b c) groupSize: 1.

	self assertGroupElements: #() of: #() groupSize: 2.
	self assertGroupElements: #(#(a)) of: #(a) groupSize: 2.
	self assertGroupElements: #(#(a b)) of: #(a b) groupSize: 2.
	self assertGroupElements: #(#(a b) #(c)) of: #(a b c) groupSize: 2.

	self assertGroupElements: #() of: #() groupSize: 3.
	self assertGroupElements: #(#(a)) of: #(a) groupSize: 3.
	self assertGroupElements: #(#(a b)) of: #(a b) groupSize: 3.
	self assertGroupElements: #(#(a b c)) of: #(a b c) groupSize: 3.
	self assertGroupElements: #(#(a b c) #(d)) of: #(a b c d) groupSize: 3.
	self assertGroupElements: #(#(a b c) #(d e)) of: #(a b c d e) groupSize: 3.
	self assertGroupElements: #(#(a b c) #(d e f)) of: #(a b c d e f) groupSize: 3.
	self assertGroupElements: #(#(a b c) #(d e f) #(g)) of: #(a b c d e f g) groupSize: 3.

]
