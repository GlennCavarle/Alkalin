Class {
	#name : #AKTSystem,
	#superclass : #Object,
	#instVars : [
		'name',
		'dispatchers',
		'actors'
	],
	#category : #'Alkalin-Actor-Actor'
}

{ #category : #'instance creation' }
AKTSystem class >> named: aString [
	
	 ^self basicNew
		 initializeWithName: aString ;
		yourself
]

{ #category : #'instance creation' }
AKTSystem class >> new [
	self error: 'Use #named: instead'
]

{ #category : #'as yet unclassified' }
AKTSystem >> createActor: anActorFactory named: aString [
	<return: #AKTActorRef>
	| actorRef |
	actorRef := AKTActorRef
		named: aString
		actorFactory: anActorFactory
		system: self
		dispatcher: (dispatchers lookup: 'default-dispatcher').
	actors add: actorRef.
	^ actorRef
]

{ #category : #initialization }
AKTSystem >> finalize [
	self terminate
]

{ #category : #initialization }
AKTSystem >> initialize [
	super initialize.
	dispatchers := AKTDispatcherList new. 
	actors := AKTActorRefList new.
]

{ #category : #initialization }
AKTSystem >> initializeWithName: aString [
	self initialize.
	name := aString.
	dispatchers add: (AKTDispatcher named:'default-dispatcher')
]

{ #category : #initialization }
AKTSystem >> stop [
	actors stopAll.
	dispatchers stopAll.
	
]
