Class {
	#name : #AKCFutureNone,
	#superclass : #AKCFutureResult,
	#category : #'Alkalin-Concurrent-Future'
}

{ #category : #testing }
AKCFutureNone >> isCompleted [
	^ false
]

{ #category : #testing }
AKCFutureNone >> isSuccess [
	^ false
]

{ #category : #enumerating }
AKCFutureNone >> onCompleteDo: aCompleteBlock inFuture: aFuture [
	aFuture addCompleteCallback: aCompleteBlock
]

{ #category : #accessing }
AKCFutureNone >> value [
	^ nil
]
