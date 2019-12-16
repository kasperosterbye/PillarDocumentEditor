"
!! Purpose

I represent a section in Pillar. Pillar has no notion of sections. So I define a section at level X to be:

- the header at level X (represented in the iv ==header==)
- all nodes from that header up till the next header node (==contents==)
- all sub sections of level X++ (==subsections==)
- uptil next header at level X

''Notice: a non-header pillar node will """"always"""" belong to the closest previous header. That is, a section is always on the form: ==header contents* subsections*== ''


"
Class {
	#name : #PDESection,
	#superclass : #Object,
	#instVars : [
		'header',
		'contents',
		'subsections'
	],
	#category : #'Pillar Document Editor'
}

{ #category : #'as yet unclassified' }
PDESection class >> buildSection: section level: level from: nodeStream [
	| node |
	[ node := nodeStream peek ] whileNotNil: [ 
		(node isKindOf: PRHeader)
			ifTrue: [ 
				| subSection |
				node level <= level ifTrue: [ ^ self ].
				subSection := self new header: node.
				nodeStream next.
				self buildSection: subSection level: node level from: nodeStream.
				section addSubsection: subSection ]
			ifFalse: [ 
				section addContentsNode: node.
				nodeStream next ] ]
]

{ #category : #'as yet unclassified' }
PDESection class >> sectionsOf: pillarDocument [
	"I return a section tree build based on a pillar document"
	|  section nodeStream|
	section := self new header: pillarDocument.
	nodeStream := pillarDocument children readStream.
	self buildSection: section level: 0 from: nodeStream.
	^ section
	
]

{ #category : #adding }
PDESection >> addContentsNode: pillarNode [
	contents add: pillarNode 
]

{ #category : #adding }
PDESection >> addSubsection: subsection [
	subsections add: subsection 
]

{ #category : #accessing }
PDESection >> contents [
	^ contents
]

{ #category : #'gt-inspection' }
PDESection >> gtInspectSection: composite [
	<gtInspectorPresentationOrder: 50>
	composite tree
		shouldValidate: false;
		title: 'Document';
		display: [ :each | 
			each subsections
				ifNotEmpty: [ each subsections ]
				ifEmpty: [ #(  ) ] ];
		children: [ :each | 
			each subsections
				ifNotEmpty: [ each subsections ]
				ifEmpty: [ #(  ) ] ];
		format: [ :each | each title contractTo: 50 ]
]

{ #category : #accessing }
PDESection >> header [
	^ header
]

{ #category : #accessing }
PDESection >> header: anObject [
	header := anObject
]

{ #category : #initialization }
PDESection >> initialize [
	contents := OrderedCollection new.
	subsections := OrderedCollection new.
]

{ #category : #accessing }
PDESection >> subsections [
	^ subsections
]

{ #category : #accessing }
PDESection >> title [
	^ (header isKindOf: PRHeader)
		  ifTrue: [ header text ]
		  ifFalse: [ 'Document' ]
]
