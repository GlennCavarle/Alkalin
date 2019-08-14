Class {
	#name : #AKCFutureCompleted,
	#superclass : #AKCFutureResult,
	#instVars : [
		'value'
	],
	#category : #'Alkalin-Concurrent-Future'
}

{ #category : #'instance creation' }
AKCFutureCompleted class >> with: aValue [
	^ self basicNew
		initializeWithValue: aValue;
		yourself
]

{ #category : #initialization }
AKCFutureCompleted >> initializeWithValue: aValue [
	self initialize.
	value := aValue.
]

{ #category : #testing }
AKCFutureCompleted >> isCompleted [
	^ true
]

{ #category : #testing }
AKCFutureCompleted >> isSuccess [
	^ (value isKindOf: Error) not
]

{ #category : #enumerating }
AKCFutureCompleted >> onCompleteDo: aCompleteBlock inFuture: aFuture [
	aFuture executeCallback: aCompleteBlock
]

{ #category : #accessing }
AKCFutureCompleted >> value [
	^ value
]
