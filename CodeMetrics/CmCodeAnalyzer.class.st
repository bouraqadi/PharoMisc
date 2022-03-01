Class {
	#name : #CmCodeAnalyzer,
	#superclass : #Object,
	#instVars : [
		'categories',
		'categoriesMatchString',
		'classes',
		'methods'
	],
	#category : #'CodeMetrics-Kernel'
}

{ #category : #analyzing }
CmCodeAnalyzer >> addClassMethodsInClass: aClass [

	methods addAll: aClass class localMethods
]

{ #category : #analyzing }
CmCodeAnalyzer >> addClassesInCategory: aCategory [
	classes addAll: (SystemOrganizer default classesInCategory: aCategory)
]

{ #category : #analyzing }
CmCodeAnalyzer >> addInstanceMethodsInClass: aClass [
	methods addAll: aClass localMethods.

]

{ #category : #analyzing }
CmCodeAnalyzer >> addMethodsInClass: aClass [
	self addInstanceMethodsInClass: aClass.
	self addClassMethodsInClass: aClass
]

{ #category : #accessing }
CmCodeAnalyzer >> categories [

	^ categories ifNil: [ self initCategories ]
]

{ #category : #accessing }
CmCodeAnalyzer >> categoriesCount [

	^self categories size
]

{ #category : #initialization }
CmCodeAnalyzer >> categoriesMatchString: aString [

	categoriesMatchString := aString.
	self reset
]

{ #category : #accessing }
CmCodeAnalyzer >> classes [

	^ classes ifNil: [ self initClasses ]
]

{ #category : #accessing }
CmCodeAnalyzer >> classesCount [

	^ self classes size
]

{ #category : #initialization }
CmCodeAnalyzer >> initCategories [

	^categories := SystemOrganizer default categoriesMatching: categoriesMatchString
]

{ #category : #initialization }
CmCodeAnalyzer >> initClasses [

	classes := Set new.
	self categories do: [ :each | 
		self addClassesInCategory: each ].
	^ classes
]

{ #category : #initialization }
CmCodeAnalyzer >> initMethods [

	methods := Set new.
	self classes do: [ :each | 
		self addMethodsInClass: each ].
	^ methods
]

{ #category : #accessing }
CmCodeAnalyzer >> methods [

	^ methods ifNil: [ self initMethods ]
]

{ #category : #accessing }
CmCodeAnalyzer >> methodsCount [

	^ self methods size
]

{ #category : #initialization }
CmCodeAnalyzer >> reset [

	categories := nil.
	classes := nil.
	methods := nil
]
