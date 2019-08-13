Class {
	#name : #AKCFuture,
	#superclass : #Object,
	#instVars : [
		'result',
		'task',
		'executionContext',
		'completeCallbacks',
		'valueSemaphore'
	],
	#category : #'Alkalin-Concurrent-Future'
}

{ #category : #private }
AKCFuture >> addCompleteCallback: aCompleteBlock [
	self assertNotCompleted.
	completeCallbacks add: aCompleteBlock
]

{ #category : #private }
AKCFuture >> assertNotCompleted [
	self isCompleted
		ifTrue: [ Error signal: 'Future already completed' ]
]

{ #category : #private }
AKCFuture >> completeWith: aValue [
	self assertNotCompleted.
	result := AKCFutureCompleted with: aValue.
	completeCallbacks do: [ :each | self executeCallback: each ].
	valueSemaphore signal.
]

{ #category : #private }
AKCFuture >> executeCallback: aCompleteBlock [
	self executionContext execute: [ aCompleteBlock value: result value ]
]

{ #category : #private }
AKCFuture >> executionContext [
	^ executionContext ifNil: [ executionContext := AKCExecutor defaultExecutor ]
]

{ #category : #initialization }
AKCFuture >> initialize [
	super initialize.
	valueSemaphore := Semaphore new.
	completeCallbacks := OrderedCollection new.
	result := AKCFutureNone new
]

{ #category : #testing }
AKCFuture >> isCompleted [
	^ result isCompleted
]

{ #category : #callbacks }
AKCFuture >> onCompleteDo: aCompleteBlock [
	result onCompleteDo: aCompleteBlock inFuture: self
		
	
]

{ #category : #callbacks }
AKCFuture >> onFailureDo: aFailureBlock [
	self
		onCompleteDo: [ :r | 
			(r isKindOf: Error)
				ifTrue: [ aFailureBlock value: r ] ]
]

{ #category : #callbacks }
AKCFuture >> onSuccessDo: aSuccessBlock [
	self
		onCompleteDo: [ :r | 
			(r isKindOf: Error)
				ifFalse: [ aSuccessBlock value: r ] ] 
]

{ #category : #accessing }
AKCFuture >> value [
	^ result value
]

{ #category : #synchronization }
AKCFuture >> waitForCompletion: aTimeout [

	self isCompleted ifFalse: [ | expired |
		expired := valueSemaphore waitTimeoutMSecs: aTimeout asMilliSeconds.
		expired ifTrue: [ AKCTimeoutException signal ] ]
]
