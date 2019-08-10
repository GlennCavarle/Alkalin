Class {
	#name : #AKTEnvelope,
	#superclass : #Object,
	#instVars : [
		'message',
		'sender'
	],
	#category : #'Alkalin-Actor-Dispatch'
}

{ #category : #'instance creation' }
AKTEnvelope class >> message: aMessage sender: aSender [
	^ self basicNew initializeWithMessage: aMessage sender: aSender
]

{ #category : #'instance creation' }
AKTEnvelope class >> new [
	self error: 'Use #message:sender: instead'
]

{ #category : #initialization }
AKTEnvelope >> initializeWithMessage: aMessage sender: aSender [
	self initialize.
	message := aMessage.
	sender := aSender
]

{ #category : #accessing }
AKTEnvelope >> message [
	^ message
]

{ #category : #accessing }
AKTEnvelope >> sender [
	^ sender
]
