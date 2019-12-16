Class {
	#name : #PDEApp,
	#superclass : #Object,
	#category : #'Pillar Document Editor'
}

{ #category : #accessing }
PDEApp class >> bookDescription [
	| url contents|
	url := 'https://raw.githubusercontent.com/SquareBracketAssociates/Booklet-PublishingAPillarBooklet/master/Chapters/BookTester-Documentation.pillar'.
	contents := (ZnEasy get: url) entity string.
	^PRPillarParser parse: contents.
	
]
