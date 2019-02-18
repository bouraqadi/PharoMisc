Extension { #name : #Duration }

{ #category : #'*PharoExtra-Chronology' }
Duration >> daysCount [
	^self daysSecondsCount quo: self secondsInDay

]

{ #category : #'*PharoExtra-Chronology' }
Duration >> daysSecondsCount [
	^self weeksSecondsCount rem: self secondsInWeek

]

{ #category : #'*PharoExtra-Chronology' }
Duration >> hoursCount [
	^self hoursSecondsCount quo: SecondsInHour
]

{ #category : #'*PharoExtra-Chronology' }
Duration >> hoursSecondsCount [
	^self daysSecondsCount rem: self secondsInDay

]

{ #category : #'*PharoExtra-Chronology' }
Duration >> millisecondsCount [
	^self wholeMilliseconds
]

{ #category : #'*PharoExtra-Chronology' }
Duration >> minutesCount [
	^self minutes
]

{ #category : #'*PharoExtra-Chronology' }
Duration >> monthSecondsCount [
	^ self totalSeconds rem: self secondsInYear
]

{ #category : #'*PharoExtra-Chronology' }
Duration class >> months: aNumber [
	^self seconds: aNumber * self secondsInMonth
]

{ #category : #'*PharoExtra-Chronology' }
Duration >> monthsCount [
	^ self monthSecondsCount quo: self secondsInMonth
]

{ #category : #'*PharoExtra-Chronology' }
Duration >> secondsCount [
	^self seconds
]

{ #category : #'*PharoExtra-Chronology' }
Duration class >> secondsInDay [
	^86400
]

{ #category : #'*PharoExtra-Chronology' }
Duration >> secondsInDay [
	^self class secondsInDay
]

{ #category : #'*PharoExtra-Chronology' }
Duration class >> secondsInMonth [
	^2628000
]

{ #category : #'*PharoExtra-Chronology' }
Duration >> secondsInMonth [
	^self class secondsInMonth
]

{ #category : #'*PharoExtra-Chronology' }
Duration class >> secondsInWeek [
	^604800
]

{ #category : #'*PharoExtra-Chronology' }
Duration >> secondsInWeek [
	^self class secondsInWeek
]

{ #category : #'*PharoExtra-Chronology' }
Duration class >> secondsInYear [
	^31536000
]

{ #category : #'*PharoExtra-Chronology' }
Duration >> secondsInYear [
	^self class secondsInYear
]

{ #category : #'*PharoExtra-Chronology' }
Duration >> weeksCount [
	^ self weeksSecondsCount quo: self secondsInWeek
]

{ #category : #'*PharoExtra-Chronology' }
Duration >> weeksSecondsCount [
	^ self monthSecondsCount rem: self secondsInMonth
]

{ #category : #'*PharoExtra-Chronology' }
Duration >> yearsCount [
	^self totalSeconds quo: self secondsInYear
]
