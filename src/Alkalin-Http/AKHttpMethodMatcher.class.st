Class {
	#name : #AKHttpMethodMatcher,
	#superclass : #AKHttpMatcher,
	#instVars : [
		'methods',
		'allowsAny'
	],
	#category : #'Alkalin-Http-Routing'
}

{ #category : #'instance creation' }
AKHttpMethodMatcher class >> fromArray: anArray [
	^ super new
		initializeFromArray: anArray;
		yourself
]

{ #category : #accessing }
AKHttpMethodMatcher >> allowsAny [
	^ allowsAny
]

{ #category : #initialization }
AKHttpMethodMatcher >> initialize [
	super initialize.
	allowsAny := false
]

{ #category : #initialization }
AKHttpMethodMatcher >> initializeFromArray: anArray [
	methods := anArray collect: [ :each | each asUppercase asSymbol ].
	(methods size = 1 and: [ methods first = #ANY ]) ifTrue: [ allowsAny := true ]
]

{ #category : #'request matching' }
AKHttpMethodMatcher >> matchRequest: anHttpRequest [
	self allowsAny ifTrue: [ ^ true ].
	^ methods anySatisfy: [ :each | each = anHttpRequest method ]
]

{ #category : #accessing }
AKHttpMethodMatcher >> methods [
	^ methods
]
