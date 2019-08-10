Class {
	#name : #AKTActorBox,
	#superclass : #Object,
	#instVars : [
		'mailbox',
		'dispatcher',
		'actor',
		'context',
		'currentEnvelope',
		'actorRef',
		'actorFactory',
		'system'
	],
	#category : #'Alkalin-Actor-Actor'
}

{ #category : #'instance creation' }
AKTActorBox class >> fromActorRef: anActorRef actorFactory: anActorFactory system: anActorSystem dispatcher: aDispatcher [
	^ self basicNew initializeFromActorRef: anActorRef actorFactory: anActorFactory system: anActorSystem dispatcher: aDispatcher
]

{ #category : #'instance creation' }
AKTActorBox class >> new [
	self error: 'Use #fromActorRef:actorFactory:system:dispatcher: instead'
]

{ #category : #accessing }
AKTActorBox >> actorRef [
	^ actorRef 
]

{ #category : #accessing }
AKTActorBox >> currentSender [
	^ currentEnvelope sender ifNil: [ "@todo deadletter" nil ]
]

{ #category : #accessing }
AKTActorBox >> dispatcher [
	^ dispatcher
]

{ #category : #accessing }
AKTActorBox >> finalize [ 
	mailbox flush.
	actor := nil.
]

{ #category : #initialization }
AKTActorBox >> initializeFromActorRef: anActorRef actorFactory: anActorFactory system: anActorSystem dispatcher: aDispatcher [
	self initialize.
	actorRef := anActorRef.
	actorFactory := anActorFactory.
	dispatcher := aDispatcher.
	system := anActorSystem.
	context := AKTActorContext forActorBox: self.
	mailbox := dispatcher createMailbox.
	mailbox actorBox: self
]

{ #category : #accessing }
AKTActorBox >> mailbox [
	^ mailbox
]

{ #category : #'as yet unclassified' }
AKTActorBox >> receive: anEnvelope [
	actor
		ifNil: [ actor := actorFactory value
				context: context;
				yourself ].
	currentEnvelope := anEnvelope.
	actor receiveMessage: anEnvelope message.
	currentEnvelope := nil
]

{ #category : #'as yet unclassified' }
AKTActorBox >> sendMessage: aMessage sender: aSender [
	| anEnvelope |
	anEnvelope := AKTEnvelope message: aMessage sender: aSender.
	dispatcher dispatch: anEnvelope receiver: self
]

{ #category : #lifecycle }
AKTActorBox >> stop [
	dispatcher systemDispatch: AKTTerminateMessage new receiver: self
]

{ #category : #accessing }
AKTActorBox >> system [
	^ system 
]

{ #category : #'as yet unclassified' }
AKTActorBox >> systemReceive: aSystemMessage [
	AKMod match: aSystemMessage cases: [ :m|m
		is:AKTTerminateMessage do:[ self terminate]
	]
]

{ #category : #private }
AKTActorBox >> terminate [
	mailbox close.
	actor postStop.
	actor := nil.
	context := nil.
	dispatcher := nil.
	actorRef := nil.
	system := nil
]
