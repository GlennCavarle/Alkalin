Class {
	#name : #AKTDispatcherList,
	#superclass : #Object,
	#instVars : [
		'dispatchers'
	],
	#category : #'Alkalin-Actor-Dispatch'
}

{ #category : #adding }
AKTDispatcherList >> add: aDispatcher [
	dispatchers at: aDispatcher name put: aDispatcher 
]

{ #category : #adding }
AKTDispatcherList >> forceCleanUp [
	self stopAll.
	dispatchers removeAll.
]

{ #category : #initialization }
AKTDispatcherList >> initialize [
	super initialize.
	dispatchers := Dictionary new
]

{ #category : #adding }
AKTDispatcherList >> lookup: aKey [
	^ dispatchers at: aKey
]

{ #category : #adding }
AKTDispatcherList >> stopAll [
	dispatchers do:#stop.
]
