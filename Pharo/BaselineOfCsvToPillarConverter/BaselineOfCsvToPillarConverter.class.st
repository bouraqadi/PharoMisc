Class {
	#name : 'BaselineOfCsvToPillarConverter',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfCsvToPillarConverter',
	#package : 'BaselineOfCsvToPillarConverter'
}

{ #category : 'baselines' }
BaselineOfCsvToPillarConverter >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			baseline: 'NeoCSV' with: [
				spec repository: 'github://svenvc/NeoCSV'];
			package: #CsvToPillarConverter with: [
				spec requires: #('NeoCSV' ). ]. ].

]
