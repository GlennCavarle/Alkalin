Trait {
	#name : #TAKTActor,
	#instVars : [
		'actorContext'
	],
	#category : #'Alkalin-Actor-Actor'
}

{ #category : #accessing }
TAKTActor >> aself [
	^ actorContext aself
]

{ #category : #accessing }
TAKTActor >> context [
	^ actorContext
]

{ #category : #accessing }
TAKTActor >> context: anObject [
	actorContext := anObject
]

{ #category : #lifecycle }
TAKTActor >> postStop [
]

{ #category : #accessing }
TAKTActor >> receiveMessage: aMessage [
	self shouldBeImplemented
]

{ #category : #accessing }
TAKTActor >> sender [
	^ actorContext sender
]

{ #category : #accessing }
TAKTActor >> system [
	^ actorContext system
]
