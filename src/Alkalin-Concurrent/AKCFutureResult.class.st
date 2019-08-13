Class {
	#name : #AKCFutureResult,
	#superclass : #Object,
	#category : #'Alkalin-Concurrent-Future'
}

{ #category : #testing }
AKCFutureResult >> isCompleted [
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
