Class {
	#name : #AKHttpPathConstraintGeneric,
	#superclass : #AKHttpPathConstraint,
	#instVars : [
		'regex',
		'converter',
		'regexString'
	],
	#category : #'Alkalin-Http-Routing'
}

{ #category : #accessing }
AKHttpPathConstraintGeneric class >> regexString: aRegexString [
	^ self
		regexString: aRegexString
		converter: [ :str | str asString ]
]

{ #category : #accessing }
AKHttpPathConstraintGeneric class >> regexString: aRegexString converter: aBlock [
	^ self new
		regexString: aRegexString;
		converter: aBlock;
		yourself
]

{ #category : #accessing }
AKHttpPathConstraintGeneric class >> type [
	^ #generic
]

{ #category : #converting }
AKHttpPathConstraintGeneric >> asRegexGroup [
	^ '(', regexString , ')'
]

{ #category : #accessing }
AKHttpPathConstraintGeneric >> converter [
	^ converter
]

{ #category : #accessing }
AKHttpPathConstraintGeneric >> converter: anObject [
	converter := anObject
]

{ #category : #accessing }
AKHttpPathConstraintGeneric >> regex [
	^ regex
]

{ #category : #accessing }
AKHttpPathConstraintGeneric >> regex: anObject [
	regex := anObject
]

{ #category : #accessing }
AKHttpPathConstraintGeneric >> regexString [
	^ regexString
]

{ #category : #accessing }
AKHttpPathConstraintGeneric >> regexString: anObject [
	regexString := anObject
]
