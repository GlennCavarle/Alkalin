Class {
	#name : #AKTMailbox,
	#superclass : #Object,
	#instVars : [
		'messageQueue',
		'systemQueue',
		'task',
		'actorBox',
		'isRunning',
		'mutex',
		'isClosed'
	],
	#category : #'Alkalin-Actor-Dispatch'
}

{ #category : #accessing }
AKTMailbox >> actorBox [
	^ actorBox
]

{ #category : #accessing }
AKTMailbox >> actorBox: anObject [
	actorBox := anObject
]

{ #category : #lifecycle }
AKTMailbox >> close [
	mutex critical: [ isClosed := true ]
]

{ #category : #actions }
AKTMailbox >> dequeue [
	^ messageQueue nextOrNil 
]

{ #category : #actions }
AKTMailbox >> enqueue: aMessage [
	messageQueue nextPut: aMessage
]

{ #category : #initialization }
AKTMailbox >> initialize [
	super initialize.
	messageQueue := SharedQueue new.
	systemQueue := SharedQueue new.
	isRunning := false.
	isClosed := false.
	mutex := Mutex new.
	task := [ self process ] asTask
]

{ #category : #testing }
AKTMailbox >> isClosed [
	^ isClosed
]

{ #category : #testing }
AKTMailbox >> isRunning [
	^ isRunning
]

{ #category : #running }
AKTMailbox >> process [
	self isClosed ifTrue:[^ self].
	mutex
		critical: [ isRunning := true.
			[ self
				processSystemMessages;
				processMessages ]
				ensure: [ isRunning := false ] ]
]

{ #category : #running }
AKTMailbox >> processMessages [
	| next |
	[ next := self dequeue ] whileNotNil: [ actorBox receive: next ]
]

{ #category : #running }
AKTMailbox >> processSystemMessages [
	| next |
	[ next := self systemDequeue ] whileNotNil: [ actorBox systemReceive: next ]
]

{ #category : #actions }
AKTMailbox >> systemDequeue [
	^ systemQueue nextOrNil 
]

{ #category : #actions }
AKTMailbox >> systemEnqueue: aMessage [
	systemQueue nextPut: aMessage
]

{ #category : #accessing }
AKTMailbox >> task [
	^ task
]
