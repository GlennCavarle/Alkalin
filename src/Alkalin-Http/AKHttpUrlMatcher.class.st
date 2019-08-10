Class {
	#name : #AKHttpUrlMatcher,
	#superclass : #AKHttpMatcher,
	#instVars : [
		'pathParameters',
		'path',
		'pathRegex'
	],
	#category : #'Alkalin-Http-Routing'
}

{ #category : #'instance creation' }
AKHttpUrlMatcher class >> fromPathPattern: aString [
	^ super new
		initializeFromPathPattern: aString
		yourself
]

{ #category : #'instance creation' }
AKHttpUrlMatcher class >> fromRegex: aStringOrRegex [
	^ super new
		initializeFromRegex: aStringOrRegex asRegex;
		yourself
]

{ #category : #'instance creation' }
AKHttpUrlMatcher class >> new [
	self error: 'Use #fromPathPattern:'
]

{ #category : #private }
AKHttpUrlMatcher >> atPathParameter: aKey valueFrom: aPathString [
	^ (pathParameters at: aKey) findValueIn: aPathString
]

{ #category : #private }
AKHttpUrlMatcher >> buildPathParameters [
	| pRegex constraint|
	pathParameters := Dictionary new.
	pRegex := '\:(\w+)(\(([^/]+)\))?' asRegex.
	pRegex matchesIn: path subexpressionsDo: [ :s :ss | 
			
			constraint := (ss at: 3) 
				ifNotNil:[AKHttpPathConstraint fromString: (ss at:3)] 
				ifNil:[AKHttpPathConstraintAny].
				
			pathParameters at: ss first put:
					(AKHttpPathParameter 
						name: ss first
						pattern: s
						position: (self segmentPositionOf: ss first)
						constraint: constraint) ]
]

{ #category : #private }
AKHttpUrlMatcher >> buildRegex [
	| regexStr |
	regexStr := '^',path.
	pathParameters do: [ :each | regexStr := each copyReplaceByRegexIn: regexStr ].
	pathRegex := regexStr asRegex
]

{ #category : #private }
AKHttpUrlMatcher >> extractValuesFrom: anHttpRequest [
	<return: #Dictionary>
	|aPathString|
	aPathString := anHttpRequest pathQueryFragmentPrintString.
	^ (pathParameters collect: [ :each | each findValueIn: aPathString ])
]

{ #category : #initialization }
AKHttpUrlMatcher >> initializeFromPathPattern: aString [
	path := aString.
	self
		buildPathParameters;
		buildRegex
]

{ #category : #initialization }
AKHttpUrlMatcher >> initializeFromRegex: aRegex [
	path := ''.
	pathRegex := aRegex
]

{ #category : #'request matching' }
AKHttpUrlMatcher >> matchRequest: anHttpRequest [
	^  pathRegex matches:	anHttpRequest path
]

{ #category : #accessing }
AKHttpUrlMatcher >> path [
	^ path
]

{ #category : #private }
AKHttpUrlMatcher >> pathParameterValuesFrom: aPathString [
	<return: #Dictionary>
	
	^ (pathParameters collect: [ :each | each findValueIn: aPathString ])
]

{ #category : #accessing }
AKHttpUrlMatcher >> pathParameters [
	^ pathParameters
]

{ #category : #private }
AKHttpUrlMatcher >> segmentPositionOf: aString [
	| strPosition stream position |
	strPosition := path findString: aString.
	stream := (path copyFrom:1  to: strPosition) readStream.
	position := 0.
	[ stream atEnd ] whileFalse: [
			stream next = $/ ifTrue: [ position := position + 1 ] ].
	^ position
]
