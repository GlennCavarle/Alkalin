Class {
	#name : #AKCTestCase,
	#superclass : #TestCase,
	#category : #'Alkalin-Concurrent-Tests'
}

{ #category : #tests }
AKCTestCase >> async: aBlock [
	| sem |
	sem := Semaphore new.
	aBlock value:sem.
	sem wait.
]

{ #category : #tests }
AKCTestCase >> futureCompletedWith: aValue [
	^ AKCFutureHelper completedWith: aValue
]
