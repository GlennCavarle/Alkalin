Class {
	#name : #AKCPromise,
	#superclass : #Object,
	#instVars : [
		'task',
		'executor',
		'result',
		'future'
	],
	#category : #'Alkalin-Concurrent-Future'
}

{ #category : #accessing }
AKCPromise >> failureWith: anError [
	
]

{ #category : #accessing }
AKCPromise >> future [
	
]

{ #category : #initialization }
AKCPromise >> initialize [
	super initialize.
	future := AKCFuture new.	
]

{ #category : #accessing }
AKCPromise >> successWith: aValue [
	
]
