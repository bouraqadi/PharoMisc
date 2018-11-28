Class {
	#name : #BaselineOfCsvToPillarConverter,
	#superclass : #BaselineOf,
	#category : #BaselineOfCsvToPillarConverter
}

{ #category : #baselines }
BaselineOfCsvToPillarConverter >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			blessing: #'baseline';
			repository: 'github://bouraqadi/PharoMisc'; 
			baseline: 'NeoCSV' with: [
				spec repository: 'github://svenvc/NeoCSV'];
			package: #CsvToPillarConverter with: [
				spec requires: #('NeoCSV' ). ]. ].

]
