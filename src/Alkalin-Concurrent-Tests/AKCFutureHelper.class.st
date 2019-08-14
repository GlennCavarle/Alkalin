Class {
	#name : #AKCFutureHelper,
	#superclass : #Object,
	#instVars : [
		'lock',
		'isSuccess',
		'value',
		'isCompleted',
		'monitor',
		'future',
		'expectedValue'
	],
	#category : #'Alkalin-Concurrent-Tests'
}

{ #category : #'instance creation' }
AKCFutureHelper class >> completedWith: aValue [
	^ self basicNew initializeWith: aValue
]

{ #category : #'private callbacks' }
AKCFutureHelper >> complete: aValue [
	monitor critical: [ monitor signal: #complete ]
]

{ #category : #'private callbacks' }
AKCFutureHelper >> failure: aValue [
	monitor critical: [ monitor signal: #failure ]
]

{ #category : #accessing }
AKCFutureHelper >> futureValue [
	^ future value
]

{ #category : #initialization }
AKCFutureHelper >> initialize [ 
	super initialize.
	monitor := Monitor new.
	isCompleted := false.
	isSuccess := false.
]

{ #category : #initialization }
AKCFutureHelper >> initializeWith: aValue [
	self initialize.
	future := AKCFuture new.
	expectedValue := aValue.
	future 
		onCompleteDo: [:v| self complete: v ];
		onSuccessDo: [:v| self success: v ];
		onFailureDo: [:v| self failure: v ].
		
	
	
	
]

{ #category : #testing }
AKCFutureHelper >> isCompleted [
	^ future isCompleted 
]

{ #category : #testing }
AKCFutureHelper >> isFailure [
	^ future isFailure
]

{ #category : #testing }
AKCFutureHelper >> isSuccess [
	^ future isSuccess
]

{ #category : #'private callbacks' }
AKCFutureHelper >> success: aValue [
	monitor critical: [ monitor signal: #success ]
]

{ #category : #'task running' }
AKCFutureHelper >> waitComplete: aDuration [
	self waitFor: #complete timeout: aDuration
]

{ #category : #'task running' }
AKCFutureHelper >> waitFailure: aDuration [
	self waitFor: #failure timeout: aDuration
]

{ #category : #private }
AKCFutureHelper >> waitFor: aSignalSymbol timeout: aDuration [
	monitor critical: [ monitor waitFor: aSignalSymbol maxMilliseconds: aDuration asMilliSeconds].
	future completeWith: expectedValue 
]

{ #category : #'task running' }
AKCFutureHelper >> waitSuccess: aDuration [
	self waitFor: #success timeout: aDuration
]
