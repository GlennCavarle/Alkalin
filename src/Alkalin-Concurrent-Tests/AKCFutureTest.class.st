Class {
	#name : #AKCFutureTest,
	#superclass : #AKCTestCase,
	#category : #'Alkalin-Concurrent-Tests'
}

{ #category : #tests }
AKCFutureTest >> testOnCompleteCallback [
	| futureTest expect|
	expect := 'test'.
	futureTest := self futureCompletedWith: expect.
	futureTest waitComplete: 100 milliSeconds.
	
	self assert: futureTest isCompleted.  
	self assert: futureTest isSuccess.
	self assert: futureTest futureValue  equals: expect.
]

{ #category : #tests }
AKCFutureTest >> testOnFailureCallback [
	|expect futureTest|
	expect := Error new.
	futureTest := self futureCompletedWith: expect.
	futureTest waitFailure: 100 milliSeconds.
	
	self assert: futureTest isCompleted.  
	self assert: futureTest isFailure.
	self assert: futureTest futureValue equals: expect.
]

{ #category : #tests }
AKCFutureTest >> testOnSuccessCallback [
	| futureTest expect|
	expect := 'test'.
	futureTest := self futureCompletedWith: expect.
	futureTest waitSuccess: 100 milliSeconds.
	
	self assert: futureTest isCompleted.  
	self assert: futureTest isSuccess.
	self assert: futureTest futureValue equals: expect.
]
