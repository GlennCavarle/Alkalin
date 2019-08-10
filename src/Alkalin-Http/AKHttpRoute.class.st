Class {
	#name : #AKHttpRoute,
	#superclass : #Object,
	#instVars : [
		'name',
		'requestMatcher',
		'action'
	],
	#category : #'Alkalin-Http-Routing'
}

{ #category : #initialization }
AKHttpRoute class >> method: aVerbSymbol path: aString action: anAction [
	^ self new
		initializeWithName: (self pathToName: aString)
		methods: { aVerbSymbol }
		path: aString
		action: anAction
]

{ #category : #initialization }
AKHttpRoute class >> methods: anArrayOfVerb path: aString action: anAction [
	^ self new
		initializeWithName: (self pathToName: aString)
		methods: anArrayOfVerb
		path: aString
		action: anAction
]

{ #category : #initialization }
AKHttpRoute class >> pathToName: aPathString [
	<return: #Symbol>
	^ (aPathString collect: [ :each |  each isAlphaNumeric ifTrue: [ each ] ifFalse: [ $_ ] ]) asString asSymbol.
	
]

{ #category : #accessing }
AKHttpRoute >> action [
	^ action
]

{ #category : #initialization }
AKHttpRoute >> initializeWithName: aSymbol methods: anArray path: aString action: anAction [
	name := aSymbol.
	requestMatcher := AKHttpRequestMatcher methods: anArray path: aString.
	action := anAction.
]

{ #category : #testing }
AKHttpRoute >> matchRequest: aRequest [
	^ requestMatcher matchRequest: aRequest
]

{ #category : #accessing }
AKHttpRoute >> methods [
	^ requestMatcher methods
]

{ #category : #accessing }
AKHttpRoute >> name [
	^ name
]

{ #category : #accessing }
AKHttpRoute >> path [
	^ requestMatcher path
]

{ #category : #accessing }
AKHttpRoute >> printOn: aStream [
	aStream
		nextPut: $[;
		nextPutAll: (self methods joinUsing: '|');
		nextPutAll: '] : ';
		nextPutAll: self path;
		nextPutAll: ' -> ';
		nextPutAll: self action asString
]
