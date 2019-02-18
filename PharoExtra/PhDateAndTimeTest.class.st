Class {
	#name : #PhDateAndTimeTest,
	#superclass : #TestCase,
	#category : #'PharoExtra-Chronology'
}

{ #category : #testing }
PhDateAndTimeTest >> testToday [
	| today |
	today := DateAndTime todayHour: 14 minute: 59 second: 33.
	self assert: today year equals: Date today year. 
	self assert: today day equals: Date today day. 
	self assert: today hour24 equals: 14.
	self assert: today minute equals: 59.
	self assert: today second equals: 33.

]
