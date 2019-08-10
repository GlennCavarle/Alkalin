Class {
	#name : #AKTActorContext,
	#superclass : #Object,
	#instVars : [
		'actorBox'
	],
	#category : #'Alkalin-Actor-Actor'
}

{ #category : #'as yet unclassified' }
AKTActorContext class >> forActorBox: anActorBox [
	^ self basicNew initializeWithActorBox: anActorBox 
]

{ #category : #accessing }
AKTActorContext >> aself [
	<return: #AKTActorRef>
	^ actorBox actorRef
]

{ #category : #initialization }
AKTActorContext >> initializeWithActorBox: anActorBox [
	self initialize.
	actorBox := anActorBox
]

{ #category : #accessing }
AKTActorContext >> sender [
	<return: #AKTActorRef>
	^ actorBox currentSender
]

{ #category : #accessing }
AKTActorContext >> system [
	<return: #AKTActorSystem>
	^ actorBox system
]
