Extension { #name : #Time }

{ #category : #'*PharoExtra-Chronology' }
Time >> + aDuration [
	^self asDateAndTime + aDuration
]

{ #category : #'*PharoExtra-instance creation' }
Time class >> hour: hour minute: minute [
	^self hour: hour minute: minute second: 0
]

{ #category : #'*PharoExtra-instance creation' }
Time class >> hour: hour0to23 minute: minute0to59 second: second0to59 milliSecond: millis0to999 [ 
	^self hour: hour0to23 minute: minute0to59 second: second0to59  nanoSecond: (millis0to999 * 1000000)
]
