Class {
	#name : #CmCodeAnalyzerTest,
	#superclass : #TestCase,
	#instVars : [
		'analyzer'
	],
	#category : #'CodeMetrics-Tests-Kernel'
}

{ #category : #tests }
CmCodeAnalyzerTest >> countCategories: aString [

	analyzer categoriesMatchString: aString.
	^analyzer categoriesCount
]

{ #category : #tests }
CmCodeAnalyzerTest >> countClassesInCategories: aString [

	analyzer categoriesMatchString: aString.
	^ analyzer classesCount
]

{ #category : #tests }
CmCodeAnalyzerTest >> countMethodsInCategories: aString [

	analyzer categoriesMatchString: aString.
	^ analyzer methodsCount
]

{ #category : #tests }
CmCodeAnalyzerTest >> setUp [

	super setUp.
	analyzer := CmCodeAnalyzer new
]

{ #category : #tests }
CmCodeAnalyzerTest >> testCategoriesCount [

 2 timesRepeat: [	self
		assert: (self countCategories: 'Some unknown invalid category name')
		equals: 0.
	self
		assert: (self countCategories: 'CodeMetrics-Tests-TestSupport-AAA')
		equals: 1.
	self
		assert: (self countCategories: 'CodeMetrics-Tests-TestSupport')
		equals: 0.
	self
		assert: (self countCategories: 'CodeMetrics-Tests-TestSupport*')
		equals: 2]
]

{ #category : #tests }
CmCodeAnalyzerTest >> testClassesCount [

	self
		assert: (self countClassesInCategories:
				 'Some unknown invalid category name')
		equals: 0.
	self
		assert: (self countClassesInCategories:
				 'CodeMetrics-Tests-TestSupport-AAA')
		equals: 1.
	self
		assert: (self countClassesInCategories:
				 'CodeMetrics-Tests-TestSupport-BBB')
		equals: 2.
	self
		assert:
		(self countClassesInCategories: 'CodeMetrics-Tests-TestSupport')
		equals: 0.
	self
		assert:
		(self countClassesInCategories: 'CodeMetrics-Tests-TestSupport*')
		equals: 3
]

{ #category : #tests }
CmCodeAnalyzerTest >> testMethodsCount [

	self
		assert:
		(self countMethodsInCategories: 'Some unknown invalid category name')
		equals: 0.
	self
		assert:
		(self countMethodsInCategories: 'CodeMetrics-Tests-TestSupport-AAA')
		equals: 3.
	self
		assert:
		(self countMethodsInCategories: 'CodeMetrics-Tests-TestSupport-BBB')
		equals: 7.
	self
		assert:
		(self countMethodsInCategories: 'CodeMetrics-Tests-TestSupport')
		equals: 0.
	self
		assert:
		(self countMethodsInCategories: 'CodeMetrics-Tests-TestSupport*')
		equals: 10
]
