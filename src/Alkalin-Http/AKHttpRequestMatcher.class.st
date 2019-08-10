Class {
	#name : #AKHttpRequestMatcher,
	#superclass : #AKHttpMatcher,
	#instVars : [
		'methodMatcher',
		'urlMatcher'
	],
	#category : #'Alkalin-Http-Routing'
}

{ #category : #'instance creation' }
AKHttpRequestMatcher class >> methods: anArray path: aString [
	^ self new
		initializeWithMethods: anArray path: aString;
		yourself
]

{ #category : #accessing }
AKHttpRequestMatcher >> extractUrlValuesFrom: anHttpRequest [
	^ urlMatcher extractValuesFrom: anHttpRequest
]

{ #category : #initialization }
AKHttpRequestMatcher >> initializeWithMethods: anArray path: aString [ 
	methodMatcher := AKHttpMethodMatcher fromArray: anArray.
	urlMatcher := AKHttpUrlMatcher fromPathPattern: aString 
]

{ #category : #'request matching' }
AKHttpRequestMatcher >> matchRequest: anHttpRequest [
	^ (methodMatcher matchRequest: anHttpRequest)
		and: [ urlMatcher matchRequest: anHttpRequest ]
]

{ #category : #accessing }
AKHttpRequestMatcher >> methods [
	^ methodMatcher methods
]

{ #category : #accessing }
AKHttpRequestMatcher >> path [
	^ urlMatcher path
]
