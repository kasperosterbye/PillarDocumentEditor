Class {
	#name : #BaselineOfPillarDocumentEditor,
	#superclass : #BaselineOf,
	#category : #BaselineOfPillarDocumentEditor
}

{ #category : #baselines }
BaselineOfPillarDocumentEditor >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'PillarExporter'
				with: [ spec repository: 'github://pillar-markup/pillar:dev-7';
					loads: 'pillar exporter' ];
			package: 'Pillar Document Editor' ]
]
