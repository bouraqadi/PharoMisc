Extension { #name : #DateAndTime }

{ #category : #'*PharoExtra-Chronology' }
DateAndTime >> milliSecond [
	^self nanoSecond // 1000000
]

{ #category : #'*PharoExtra-Chronology' }
DateAndTime class >> todayHour: hour minute: minute [ 
	^self todayHour: hour minute: minute second: 0
]

{ #category : #'*PharoExtra-Chronology' }
DateAndTime class >> todayHour: hour minute: minute second: second [
	^self date: Date today time: (Time hour: hour minute: minute second: second)
]

{ #category : #'*PharoExtra-Chronology' }
DateAndTime class >> tomorrowHour: hour minute: minute [ 
	^self tomorrowHour: hour minute: minute second: 0
]

{ #category : #'*PharoExtra-Chronology' }
DateAndTime class >> tomorrowHour: hour minute: minute second: second [
	^self date: Date tomorrow time: (Time hour: hour minute: minute second: second)
]
