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
CmCodeAnalyzerTest >> summaryForCategories: aString [

	analyzer categoriesMatchString: aString.
	^analyzer summary
]

{ #category : #tests }
CmCodeAnalyzerTest >> testCategoriesCount [

 2 timesRepeat: [	self
		assert: (self countCategories: 'Some unknown invalid category name')
		equals: 0.
	self
		assert: (self countCategories:
				 'CodeMetrics-Tests-CategoryEmptyOnPurpose')
		equals: 1.
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
				 'CodeMetrics-Tests-CategoryEmptyOnPurpose')
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
		(self countMethodsInCategories: 'CodeMetrics-Tests-CategoryEmptyOnPurpose')
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

{ #category : #tests }
CmCodeAnalyzerTest >> testSummary [

	self
		assert:
		(self summaryForCategories: 'Some unknown invalid category name')
		equals: 'No category found!'.
	self
		assert: (self summaryForCategories:
				 'CodeMetrics-Tests-CategoryEmptyOnPurpose')
		equals: '0 class, 0 method'.
	self
		assert:
		(self summaryForCategories: 'CodeMetrics-Tests-TestSupport-AAA')
		equals: '1 class, 3 methods'.
	self
		assert:
		(self summaryForCategories: 'CodeMetrics-Tests-TestSupport-BBB')
		equals: '2 classes, 7 methods'.
	self
		assert:
		(self summaryForCategories: 'CodeMetrics-Tests-TestSupport')
		equals: 'No category found!'.
	self
		assert:
		(self summaryForCategories: 'CodeMetrics-Tests-TestSupport*')
		equals: '3 classes, 10 methods'
]
