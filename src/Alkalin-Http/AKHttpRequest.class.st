Class {
	#name : #AKHttpRequest,
	#superclass : #Object,
	#instVars : [
		'method',
		'uri',
		'path',
		'pathParameters',
		'queryParameters',
		'headers',
		'body',
		'attributes',
		'pathSegments'
	],
	#category : #'Alkalin-Http-Message'
}

{ #category : #'instance creation' }
AKHttpRequest class >> fromZnRequest: aZnRequest [
	^ self new initializeFromZnRequest: aZnRequest
]

{ #category : #accessing }
AKHttpRequest >> attributes [
	^ attributes
]

{ #category : #accessing }
AKHttpRequest >> body [
	^ body
]

{ #category : #accessing }
AKHttpRequest >> headers [
	^ headers
]

{ #category : #initialization }
AKHttpRequest >> initialize [
	headers := Dictionary new.
	pathParameters := Dictionary new.
	queryParameters := Dictionary new.
	attributes := Dictionary new.
]

{ #category : #initialization }
AKHttpRequest >> initializeFromZnRequest: aZnRequest [
	self initialize.
	uri := aZnRequest url pathQueryFragmentPrintString.
	path := aZnRequest url pathPrintString.
	method := aZnRequest method.
	headers := Dictionary newFrom: aZnRequest headers headers.
	pathSegments := OrderedCollection newFrom: aZnRequest url pathSegments.
	aZnRequest url query ifNotNil:[ queryParameters := Dictionary newFrom: aZnRequest url query].
	
	body := AKHttpRequestBody fromZnEntity: aZnRequest entity
	
	
]

{ #category : #accessing }
AKHttpRequest >> method [
	^ method
]

{ #category : #accessing }
AKHttpRequest >> path [
	^ path
]

{ #category : #accessing }
AKHttpRequest >> uri [
	^ uri
]
