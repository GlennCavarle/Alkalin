Class {
	#name : #AKTActorRef,
	#superclass : #AKTAbstractActorRef,
	#instVars : [
		'name',
		'system',
		'dispatcher',
		'actorFactory',
		'actorBox'
	],
	#category : #'Alkalin-Actor-Actor'
}

{ #category : #'as yet unclassified' }
AKTActorRef class >> named: aString actorFactory: anActorFactory system: anActorSystem dispatcher: aDispatcher [ 
	^ self basicNew initializeWithName: aString actorFactory: anActorFactory system: anActorSystem dispatcher: aDispatcher
]

{ #category : #'as yet unclassified' }
AKTActorRef class >> new [
	self error: 'Use #named:dispatcher:actorClass: instead'
]

{ #category : #instructions }
AKTActorRef >> ask: aMessage sender: aSender [
<return:#Future>
	|promiseActor|
	promiseActor := AKTPromiseActorRef new. 
	self tell: aMessage sender: promiseActor.
	^ promiseActor future
]

{ #category : #initialization }
AKTActorRef >> initializeWithName: aString actorFactory: anActorFactory system: anActorSystem dispatcher: aDispatcher [
	self initialize.
	name := aString.
	actorFactory := anActorFactory.
	system := anActorSystem.
	dispatcher := aDispatcher.
	actorBox := AKTActorBox fromActorRef: self actorFactory: anActorFactory system: anActorSystem dispatcher: aDispatcher
]

{ #category : #accessing }
AKTActorRef >> name [
	^ name
]

{ #category : #lifecycle }
AKTActorRef >> stop [ 
	actorBox ifNotNil:[:ab| ab stop].
	system := nil.
	dispatcher := nil.
	actorFactory := nil.
	actorBox := nil.
]

{ #category : #instructions }
AKTActorRef >> tell: aMessage sender: aSender [
	<return:#self>
	actorBox sendMessage: aMessage sender: aSender.
	^ self
]
