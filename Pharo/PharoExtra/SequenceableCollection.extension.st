Extension { #name : #SequenceableCollection }

{ #category : #'*PharoExtra-Collections' }
SequenceableCollection >> groupsOfAtMost: maxGroupSize atATimeCollect: aBlock [
	"As opposite to groupsOf:atATimeCollect: I process all elements. The last group might be smaller than the others since it includes the leftovers."
	
	| newCollection |
	newCollection := OrderedCollection new.
	self groupsOfAtMost: maxGroupSize atATimeDo: [:each | newCollection add: (aBlock value: each)].
	^newCollection
]

{ #category : #'*PharoExtra-Collections' }
SequenceableCollection >> groupsOfAtMost: maxGroupSize atATimeDo: aBlock [
	"As opposite to groupsOf:atATimeDo: I process all elements. The last group might be smaller than the others since it includes the leftovers."
	| groupIndex firstIndex lastIndex group |
	groupIndex := 1.
	firstIndex := 1.
	[ firstIndex <= self size  ] whileTrue: [
		lastIndex := (firstIndex + maxGroupSize - 1) min: self size.
	"self halt."
		group := self copyFrom: firstIndex to: lastIndex.
		aBlock cull: group.
		firstIndex := lastIndex + 1.
		groupIndex := groupIndex + 1 ].

]
