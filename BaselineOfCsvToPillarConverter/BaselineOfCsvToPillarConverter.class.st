Class {
	#name : #BaselineOfCsvToPillarConverter,
	#superclass : #BaselineOf,
	#category : #BaselineOfCsvToPillarConverter
}

{ #category : #baselines }
BaselineOfCsvToPillarConverter >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'github://bouraqadi/PharoMisc'.
		spec 
			project: 'NeoCSV' with: [
				spec
					className: #BaselineOfNeoCSV;
					repository: 'https://github.com/svenvc/NeoCSV' ];
			package: #CsvToPillarConverter with: [
				spec requires: #('NeoCSV' ). ]. ].

]
