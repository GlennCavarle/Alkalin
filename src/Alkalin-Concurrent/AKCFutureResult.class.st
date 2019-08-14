Class {
	#name : #AKCFutureResult,
	#superclass : #Object,
	#category : #'Alkalin-Concurrent-Future'
}

{ #category : #testing }
AKCFutureResult >> isCompleted [
	self subclassResponsibility 
]

{ #category : #testing }
AKCFutureResult >> isFailure [
	^ self isCompleted and:[self isSuccess not]
]

{ #category : #testing }
AKCFutureResult >> isSuccess [
	self subclassResponsibility 
]

{ #category : #enumerating }
AKCFutureResult >> onCompleteDo: aCompleteBlock inFuture: aFuture [
	self subclassResponsibility 
]

{ #category : #accessing }
AKCFutureResult >> value [
	self subclassResponsibility 
]
