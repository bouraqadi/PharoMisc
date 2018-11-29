"
Converts CSV to Pillar, ready to display on web page

CsvToPillarConverter convert
"
Class {
	#name : #CsvToPillarConverter,
	#superclass : #Object,
	#instVars : [
		'csvFileName',
		'pillarFileName',
		'folderPath'
	],
	#classVars : [
		'CsvFilePathString'
	],
	#category : #CsvToPillarConverter
}

{ #category : #converting }
CsvToPillarConverter class >> example [
	<example>
	| converter |
	converter := self new.
	converter 
		folderPathString: '/Users/noury/ReviewsAndEventOrganization/2018-09-ESUG/';
		csvFileName: 'submissions09-09.csv';
		pillarFileName: 'submissions.pillar'.
	converter convert
]

{ #category : #converting }
CsvToPillarConverter >> convert [
	| header csvReader pillarWriteStream hearderButName |
	pillarWriteStream := self pillarWriteStream.
	csvReader := NeoCSVReader on: self csvReadStream.
	header := csvReader readHeader.
	hearderButName := header allButFirst.
	csvReader
		do: [ :entry | 
			pillarWriteStream
				nextPutAll: '!!!';
				nextPutAll: entry first.
			hearderButName
				with: entry allButFirst
				do:
					[ :label :contents | self writeOn: pillarWriteStream label: label contents: contents ].
			pillarWriteStream
				lf;
				lf ].
	pillarWriteStream close
]

{ #category : #accessing }
CsvToPillarConverter >> csvFileName [
	^csvFileName
]

{ #category : #accessing }
CsvToPillarConverter >> csvFileName: aString [
	^csvFileName := aString
]

{ #category : #accessing }
CsvToPillarConverter >> csvFilePath [
	^self folderPath / self csvFileName
]

{ #category : #accessing }
CsvToPillarConverter >> csvReadStream [
	^self csvFilePath readStream.
]

{ #category : #accessing }
CsvToPillarConverter >> folderPath [
	^folderPath
]

{ #category : #accessing }
CsvToPillarConverter >> folderPathString: aString [ 
	^folderPath := aString asFileReference
]

{ #category : #converting }
CsvToPillarConverter >> isUrl: aString [
	^#('https:' 'http:') anySatisfy: [ :urlPrefix | aString beginsWith: urlPrefix ]
]

{ #category : #accessing }
CsvToPillarConverter >> pillarFileName [
	^pillarFileName
]

{ #category : #accessing }
CsvToPillarConverter >> pillarFileName: aString [
	^pillarFileName
]

{ #category : #accessing }
CsvToPillarConverter >> pillarFilePath [
	^self folderPath / self pillarFileName
]

{ #category : #accessing }
CsvToPillarConverter >> pillarWriteStream [
	| fileRef |
	fileRef := self pillarFilePath.
	fileRef ensureDelete.
	^fileRef writeStream.
]

{ #category : #converting }
CsvToPillarConverter >> writeOn: pillarWriteStream label: label contents: contents [
	| makeLink |
	contents ifNil: [ ^self ].
	pillarWriteStream
				lf;
				nextPutAll: '- ''''';
				nextPutAll: label;
				nextPutAll: ''''': ""'.
	makeLink := self isUrl: contents.
	makeLink ifTrue: [pillarWriteStream nextPut: $*  ].
	pillarWriteStream nextPutAll: contents.
	makeLink ifTrue: [pillarWriteStream nextPut: $*  ].
	pillarWriteStream nextPutAll: '""' 
]
