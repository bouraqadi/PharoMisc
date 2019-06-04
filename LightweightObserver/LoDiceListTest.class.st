Class {
	#name : #LoDiceListTest,
	#superclass : #TestCase,
	#instVars : [
		'diceList'
	],
	#category : #'LightweightObserver-Example'
}

{ #category : #tests }
LoDiceListTest >> assert6FacesFrom1to6ForEachDiceInListOfSize: expectedSize [
	self assert: diceList dice size equals: expectedSize.
	diceList dice
		do: [ :each | self assert: each faces equals: (1 to: 6) ]
]

{ #category : #tests }
LoDiceListTest >> testCreation [
	| facesDice1 facesDice2 |
	diceList := LoDiceList withTwoDice.
	self assert6FacesFrom1to6ForEachDiceInListOfSize: 2.

	1 to: 10 do: [: diceCount |
		diceList := LoDiceList withDiceCount: diceCount.
		self assert6FacesFrom1to6ForEachDiceInListOfSize: diceCount].
	
	facesDice1 := #(a b c).
	facesDice2 := { 1/2. 3.14. }.
	diceList := LoDiceList with: { 
		LoDice faces: facesDice1.
		LoDice faces: facesDice2.
	}.
	self assert: diceList dice size equals: 2.
	self assert: diceList dice first faces equals: facesDice1.
	self assert: diceList dice second faces equals: facesDice2.

]

{ #category : #tests }
LoDiceListTest >> testFacesUpChangesUponRolls [
	| oldFacesUp changedFaces facesUnchanged newFacesUp |
	diceList := LoDiceList withDiceCount: 6.
	oldFacesUp := diceList facesUp.
	changedFaces := oldFacesUp collect: [ : each | false ].
	100 timesRepeat: [ 
		diceList roll.
		newFacesUp := diceList facesUp.
		oldFacesUp withIndexDo: [ : oldFace : index |
			oldFace = (newFacesUp at: index) ifFalse: [changedFaces at: index put: true  ].
		].
		facesUnchanged := changedFaces reject: [ : isFaceChanged | isFaceChanged ].
		facesUnchanged ifEmpty: [ ^self ].
		oldFacesUp := newFacesUp.
	].
	self fail: 'All dice faces up should change upon enough roll'
]

{ #category : #tests }
LoDiceListTest >> testObserveDiceAddition [
	| addedDice |
	diceList := LoDiceList new.
	diceList afterAddToCollection: #dice do: [ : newDice | addedDice := newDice ].
	6 timesRepeat: [ 
		diceList addDice.
		self assert: addedDice == diceList dice last
	]
]

{ #category : #tests }
LoDiceListTest >> testObserveDiceRemove [
	| removedDice diceInitialCount remainingDiceIndices removeDiceIndex diceToRemove initialDice |
	diceInitialCount := 6.
	diceList := LoDiceList withDiceCount: diceInitialCount.
	initialDice := diceList dice copy.
	diceList afterRemoveFromCollection: #dice do: [ : oldDice | removedDice := oldDice ].
	remainingDiceIndices := (1 to: diceInitialCount) asSet.
	diceInitialCount timesRepeat: [ 
		removeDiceIndex := remainingDiceIndices atRandom.
		remainingDiceIndices remove: removeDiceIndex.
		diceToRemove := initialDice at: removeDiceIndex.
		diceList removeDice: diceToRemove.
		self assert: removedDice == diceToRemove
	]
	

]

{ #category : #tests }
LoDiceListTest >> testObserveDiceReplace [
	| addedDice removedDice diceIndex initialDice |
	diceList := LoDiceList withDiceCount: 2.
	diceList afterReplaceInCollection: #dice do: [ : index : newDice : oldDice |
		diceIndex := index. 
		addedDice := newDice.
		removedDice := oldDice ].
	initialDice := diceList dice copy.
	{LoDice faces: #(a b c).
	LoDice faces: #(a a a b).
	} withIndexDo: [ : diceToInsert : index|
		diceList diceAt: index put: diceToInsert.
		self assert: addedDice ==  diceToInsert.
		self assert: removedDice == (initialDice at: index)
	].

]
