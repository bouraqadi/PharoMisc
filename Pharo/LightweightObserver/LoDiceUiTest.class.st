Class {
	#name : #LoDiceUiTest,
	#superclass : #TestCase,
	#category : #'LightweightObserver-Example'
}

{ #category : #tests }
LoDiceUiTest >> testDiceAdderObservedByPresenter [
	| diceAdder presenter displayedFaces faceUpStrings oldTotal |
	diceAdder := LoDiceAdder withTwoDice.
	presenter := LoDiceAdderPresenter new.
	presenter linkTo: diceAdder.
	10 timesRepeat: [
		diceAdder roll.
		displayedFaces := presenter dicePresenters collect: [: each | each diceFaceUpString].
		faceUpStrings := diceAdder facesUp collect: #asString.
		self assert: displayedFaces asArray equals: faceUpStrings asArray.
		self assert: presenter totalString equals: diceAdder total asString].
	oldTotal := diceAdder total.
	100 timesRepeat: [
		presenter rollButton performAction.
		oldTotal = diceAdder total ifFalse: [ ^self ]
	].
	self fail: 'Click on Roll button should make total change'

]

{ #category : #tests }
LoDiceUiTest >> testDiceListObservedByPresenter [
	| diceList presenter displayedFaces faceUpStrings |
	diceList := LoDiceList withTwoDice.
	presenter := LoDiceListPresenter new.
	presenter linkTo: diceList.
	10 timesRepeat: [
		diceList roll.
		displayedFaces := presenter dicePresenters collect: [: each | each diceFaceUpString].
		faceUpStrings := diceList facesUp collect: #asString.
		self assert: displayedFaces asArray equals: faceUpStrings asArray].

]

{ #category : #tests }
LoDiceUiTest >> testDiceObservedByPresenter [
	| dice presenter oldFaceUp |
	dice := LoDice new.
	presenter := LoDicePresenter new.
	presenter linkTo: dice.
	10 timesRepeat: [
		dice roll.
		self assert: presenter diceFaceUpString equals: dice faceUp asString].
	oldFaceUp := dice faceUp.
	100 timesRepeat: [
		presenter diceFaceUpPresenter performAction.
		oldFaceUp = dice faceUp ifFalse: [ ^self ].
	].
	self fail: 'Click on presenter should make dice roll'

]
