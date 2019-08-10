Class {
	#name : #AKTActor,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#category : #'Alkalin-Actor-Actor'
}

{ #category : #accessing }
AKTActor >> aself [
	^ context aself
]

{ #category : #accessing }
AKTActor >> context [
	^ context
]

{ #category : #accessing }
AKTActor >> context: anObject [
	context := anObject
]

{ #category : #'as yet unclassified' }
AKTActor >> postStop [
]

{ #category : #accessing }
AKTActor >> receiveMessage: aMessage [
	Transcript crShow: self aself name ,'-',aMessage.
	self sender tell: 'ok'
]

{ #category : #accessing }
AKTActor >> sender [
	^ context sender
]

{ #category : #accessing }
AKTActor >> system [
	^ context system
]
