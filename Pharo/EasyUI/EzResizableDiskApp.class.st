Class {
	#name : #EzResizableDiskApp,
	#superclass : #EzApp,
	#traits : 'EzTDemoApp',
	#classTraits : 'EzTDemoApp classTrait',
	#instVars : [
		'disk'
	],
	#category : #'EasyUI-Examples-Apps'
}

{ #category : #actions }
EzResizableDiskApp >> decreaseDiskDiameter [

	| newDiameter |
	newDiameter := disk minDiameter - self diameterDelta.
	disk diameter: newDiameter
]

{ #category : #actions }
EzResizableDiskApp >> decreaseDiskHeight [
	disk height: disk height - self diameterDelta
]

{ #category : #actions }
EzResizableDiskApp >> decreaseDiskWidth [
	disk width: disk width - self diameterDelta
]

{ #category : #initialization }
EzResizableDiskApp >> defaultTitle [

	^ 'Resize with arrows - Proportioal add Shift - reset with space'
]

{ #category : #actions }
EzResizableDiskApp >> diameterDelta [
	^5
]

{ #category : #initialization }
EzResizableDiskApp >> diskCenter [
	^drawingBoard width @ drawingBoard height // 2
]

{ #category : #initialization }
EzResizableDiskApp >> diskInitialDiameter [
	^ 50
]

{ #category : #actions }
EzResizableDiskApp >> increaseDiskDiameter [

	| newDiameter |
	newDiameter := disk maxDiameter + self diameterDelta.
	disk diameter: newDiameter
]

{ #category : #actions }
EzResizableDiskApp >> increaseDiskHeight [
	disk height: disk height + self diameterDelta
]

{ #category : #actions }
EzResizableDiskApp >> increaseDiskWidth [

	disk width: disk width + self diameterDelta
]

{ #category : #initialization }
EzResizableDiskApp >> initDecreaseActions [

	| leftArrow downArrow shiftLeftArrow shiftDownArrow shiftLeftOrDownArrow |
	leftArrow := Character arrowLeft asKeyCombination.
	disk
		bindKeyCombination: leftArrow
		toAction: [ self decreaseDiskWidth ].
	downArrow := Character arrowDown asKeyCombination.
	disk
		bindKeyCombination: downArrow
		toAction: [ self decreaseDiskHeight ].
	shiftLeftArrow := leftArrow modifiedBy: KMModifier shift.
	shiftDownArrow := downArrow modifiedBy: KMModifier shift.
	shiftLeftOrDownArrow := KMKeyCombinationChoice withShortcuts: { 
			                       shiftLeftArrow.
			                       shiftDownArrow }.
	disk
		bindKeyCombination: shiftLeftOrDownArrow
		toAction: [ self decreaseDiskDiameter ]
]

{ #category : #initialization }
EzResizableDiskApp >> initIncreaseActions [

	| rightArrow upArrow shiftRightArrow shiftUpArrow shiftRightOrUpArrow |
	rightArrow := Character arrowRight asKeyCombination.
	disk
		bindKeyCombination: rightArrow
		toAction: [ self increaseDiskWidth ].
	upArrow := Character arrowUp asKeyCombination.
	disk
		bindKeyCombination: upArrow
		toAction: [ self increaseDiskHeight ].
	shiftRightArrow := rightArrow modifiedBy: KMModifier shift.
	shiftUpArrow := upArrow modifiedBy: KMModifier shift.
	shiftRightOrUpArrow := KMKeyCombinationChoice withShortcuts: { 
			                       shiftRightArrow.
			                       shiftUpArrow }.
	disk
		bindKeyCombination: shiftRightOrUpArrow
		toAction: [ self increaseDiskDiameter ]
]

{ #category : #initialization }
EzResizableDiskApp >> initialize [

	| space |
	super initialize.
	disk := EzOval
		        circleCenter: self diskCenter
		        diameter: self diskInitialDiameter.
	drawingBoard add: disk.
	space := Character space asKeyCombination.
	disk bindKeyCombination: space toAction: [ self resetDiskDiameter ].
	self initIncreaseActions.
	self initDecreaseActions.
	

]

{ #category : #actions }
EzResizableDiskApp >> resetDiskDiameter [

	disk width: self diskInitialDiameter  height: self diskInitialDiameter 
]
