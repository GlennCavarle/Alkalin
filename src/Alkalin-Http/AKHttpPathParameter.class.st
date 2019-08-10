Class {
	#name : #AKHttpPathParameter,
	#superclass : #Object,
	#instVars : [
		'name',
		'pattern',
		'position',
		'constraint'
	],
	#category : #'Alkalin-Http-Routing'
}

{ #category : #'as yet unclassified' }
AKHttpPathParameter class >> name: aNameString pattern: aPatternString position: aNumber constraint: aRegexString [
	^ self new
		name: aNameString asSymbol;
		pattern: aPatternString;
		position: aNumber;
		constraint: aRegexString;
		yourself
]

{ #category : #accessing }
AKHttpPathParameter >> constraint [
	^ constraint
]

{ #category : #accessing }
AKHttpPathParameter >> constraint: anObject [
	constraint := anObject
]

{ #category : #copying }
AKHttpPathParameter >> copyReplaceByRegexIn: aString [
	^ aString copyReplaceAll: pattern with: self constraint asRegexGroup
]

{ #category : #'as yet unclassified' }
AKHttpPathParameter >> extractValueFrom: aPathString [
]

{ #category : #accessing }
AKHttpPathParameter >> name [
	^ name
]

{ #category : #accessing }
AKHttpPathParameter >> name: anObject [
	name := anObject
]

{ #category : #accessing }
AKHttpPathParameter >> pattern [
	^ pattern
]

{ #category : #accessing }
AKHttpPathParameter >> pattern: anObject [
	pattern := anObject
]

{ #category : #accessing }
AKHttpPathParameter >> position [
	^ position
]

{ #category : #accessing }
AKHttpPathParameter >> position: anObject [
	position := anObject
]
