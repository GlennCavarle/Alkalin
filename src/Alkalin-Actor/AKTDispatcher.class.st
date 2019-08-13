Class {
	#name : #AKTDispatcher,
	#superclass : #Object,
	#instVars : [
		'name',
		'workerPool'
	],
	#category : #'Alkalin-Actor-Dispatch'
}

{ #category : #'instance creation' }
AKTDispatcher class >> named: aString [
	
	 ^self basicNew
		 initializeWithName: aString ;
		yourself
]

{ #category : #'instance creation' }
AKTDispatcher class >> new [
	self error: 'Use #named: instead'
]

{ #category : #private }
AKTDispatcher >> createMailbox [
	^ AKTMailbox new
]

{ #category : #private }
AKTDispatcher >> dispatch: anEnvelope receiver: aReceiver [ 
	aReceiver mailbox enqueue: anEnvelope.
	self processMailbox: aReceiver mailbox
]

{ #category : #'task execution' }
AKTDispatcher >> executeTask: aTask [
	workerPool execute: aTask
]

{ #category : #initialization }
AKTDispatcher >> finalize [
	self stop
]

{ #category : #initialization }
AKTDispatcher >> initializeWithName: aString [
	self initialize.
	name := aString.
	self initializeWorkerPool
]

{ #category : #initialization }
AKTDispatcher >> initializeWorkerPool [
	workerPool := (AKCFixedThreadPool
		named:('akt-{NAME}-{ID}' format:
					{(#NAME -> name).
					(#ID -> UUID new)} asDictionary)
		maxPoolSize: 5) 
]

{ #category : #accessing }
AKTDispatcher >> name [
	^ name
]

{ #category : #private }
AKTDispatcher >> processMailbox: aMailbox [

	(aMailbox isRunning or:[aMailbox isClosed]) ifTrue:[^ self].
	self executeTask: aMailbox task.
]

{ #category : #lifecycle }
AKTDispatcher >> stop [
	workerPool stop.
]

{ #category : #private }
AKTDispatcher >> systemDispatch: aSystemMessage receiver: aReceiver [ 
	aReceiver mailbox systemEnqueue: aSystemMessage.
	self processMailbox: aReceiver mailbox
]
