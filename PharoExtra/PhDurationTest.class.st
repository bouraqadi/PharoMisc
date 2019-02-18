Class {
	#name : #PhDurationTest,
	#superclass : #TestCase,
	#category : #'PharoExtra-Chronology'
}

{ #category : #testing }
PhDurationTest >> testDaysCount [
	self assert: 1 day daysCount equals: 1.
	self assert: 6 days daysCount equals: 6.
	self assert: 7 days daysCount equals: 0.
	self assert: 8 days daysCount equals: 1.
	self assert: 14 days daysCount equals: 0.
	self assert: 30 days daysCount equals: 2.
	self assert: 1 week daysCount equals: 0.
	self assert: 4 weeks daysCount equals: 0.
	self assert: 1 month daysCount equals: 0.
	self assert: 6 months daysCount equals: 0.
	self assert: 1 year daysCount equals: 0.
	self assert: 5 years daysCount equals: 0.
	
]

{ #category : #testing }
PhDurationTest >> testHoursMinutesSecondsCount [
	| duration |
	duration := 26 hours + 83 minutes + 75 seconds.
	self assert: duration daysCount equals: 1.
	self assert: duration hoursCount equals: 3.
	self assert: duration minutesCount equals: 24.
	self assert: duration secondsCount equals: 15.
	
]

{ #category : #testing }
PhDurationTest >> testMonthsCount [
	self assert: 1 day monthsCount equals: 0.
	self assert: 30 days monthsCount equals: 0.
	self assert: 31 days monthsCount equals: 1.
	self assert: 60 days monthsCount equals: 1.
	self assert: 61 days monthsCount equals: 2.
	self assert: 365 days monthsCount equals: 0.
	self assert: 400 days monthsCount equals: 1.
	self assert: 1 week monthsCount equals: 0.
	self assert: 4 weeks monthsCount equals: 0.
	self assert: 5 weeks monthsCount equals: 1.
	self assert: 10 weeks monthsCount equals: 2.
	self assert: 1 month monthsCount equals: 1.
	self assert: 6 months monthsCount equals: 6.
	self assert: 12 months monthsCount equals: 0.
	self assert: 13 months monthsCount equals: 1.
	self assert: 0 year monthsCount equals: 0.
	self assert: 1 year monthsCount equals: 0.
	self assert: 23 years monthsCount equals: 0.
	
]

{ #category : #testing }
PhDurationTest >> testWeeksCount [
	self assert: 1 day weeksCount equals: 0.
	self assert: 6 days weeksCount equals: 0.
	self assert: 7 days weeksCount equals: 1.
	self assert: 13 days weeksCount equals: 1.
	self assert: 14 days weeksCount equals: 2.
	self assert: 30 days weeksCount equals: 4.
	self assert: 40 days weeksCount equals: 1.
	self assert: 1 week weeksCount equals: 1.
	self assert: 4 weeks weeksCount equals: 4.
	self assert: 5 weeks weeksCount equals: 0.
	self assert: 8 weeks weeksCount equals: 3.
	self assert: 1 month weeksCount equals: 0.
	self assert: 6 months weeksCount equals: 0.
	self assert: 1 year weeksCount equals: 0.
	self assert: 5 years weeksCount equals: 0.
	
]

{ #category : #testing }
PhDurationTest >> testYearsCount [
	self assert: 1 day yearsCount equals: 0.
	self assert: 364 days yearsCount equals: 0.
	self assert: 365 days yearsCount equals: 1.
	self assert: 366 days yearsCount equals: 1.
	self assert: 400 days yearsCount equals: 1.
	self assert: 1095 days yearsCount equals: 3.
	self assert: 1 week yearsCount equals: 0.
	self assert: 52 weeks yearsCount equals: 0.
	self assert: 53 weeks yearsCount equals: 1.
	self assert: 54 weeks yearsCount equals: 1.
	self assert: 104 weeks yearsCount equals: 1.
	self assert: 105 weeks yearsCount equals: 2.
	self assert: 106 weeks yearsCount equals: 2.
	self assert: 1 month yearsCount equals: 0.
	self assert: 11 months yearsCount equals: 0.
	self assert: 12 months yearsCount equals: 1.
	self assert: 13 months yearsCount equals: 1.
	self assert: 48 months yearsCount equals: 4.
	self assert: 0 year yearsCount equals: 0.
	self assert: 1 year yearsCount equals: 1.
	self assert: 23 years yearsCount equals: 23.
	
]
