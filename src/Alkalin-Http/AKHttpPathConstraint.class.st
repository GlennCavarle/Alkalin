Class {
	#name : #AKHttpPathConstraint,
	#superclass : #Object,
	#category : #'Alkalin-Http-Routing'
}

{ #category : #converting }
AKHttpPathConstraint class >> asRegexGroup [
	^ '(', self regexString , ')'
]

{ #category : #converting }
AKHttpPathConstraint class >> canExtract: aString [
	^ self regexString asRegex matches: aString
]

{ #category : #converting }
AKHttpPathConstraint class >> convert: aString [
^ self converter value: aString
]

{ #category : #converting }
AKHttpPathConstraint class >> converter [
	self subclassResponsibility 
]

{ #category : #converting }
AKHttpPathConstraint class >> fromString: aString [
[ 
	AKHttpPathConstraint subclasses detect: [:cls| cls type = aString]
		ifFound: [:cls | ^ cls  ].
	
	(aString isValidGlobalName and:[Smalltalk hasClassNamed: aString  ])
		ifTrue: [ ^ self class environment at: aString asSymbol ].
		
	^ AKHttpPathConstraintGeneric regexString: aString.
] on: Error do:[AKHttpInvalidPathConstraint signalForConstraint: aString]
	
	
	
]

{ #category : #converting }
AKHttpPathConstraint class >> regexString [
	self subclassResponsibility 
]

{ #category : #converting }
AKHttpPathConstraint class >> type [
	self subclassResponsibility 
]
