Class {
	#name : #AKTActorRefList,
	#superclass : #Object,
	#instVars : [
		'actors'
	],
	#category : #'Alkalin-Actor-Actor'
}

{ #category : #adding }
AKTActorRefList >> add: anActorRef [
	actors at: anActorRef name put: anActorRef 
]

{ #category : #adding }
AKTActorRefList >> forceCleanUp [
	self stopAll.
	actors removeAll.
]

{ #category : #initialization }
AKTActorRefList >> initialize [
	super initialize.
	actors := Dictionary new
]

{ #category : #adding }
AKTActorRefList >> lookup: aKey [
	^ actors at: aKey
]

{ #category : #adding }
AKTActorRefList >> stopAll [
	actors do:#stop.
	
]
