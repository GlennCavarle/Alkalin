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

{ #category : #'as yet unclassified' }
AKTDispatcher >> createMailbox [
	^ AKTMailbox new
]

{ #category : #'as yet unclassified' }
AKTDispatcher >> dispatch: anEnvelope receiver: aReceiver [ 
	aReceiver mailbox enqueue: anEnvelope.
	self processMailbox: aReceiver mailbox
]

{ #category : #'task execution' }
AKTDispatcher >> executeTask: aTask [
	workerPool schedule: aTask
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
	workerPool := TKTWorkerPool new.
	workerPool name: ('akt-{NAME}-{ID}' format: {(#NAME -> name).(#ID -> UUID new)} asDictionary).
	workerPool poolMaxSize: 5.
	workerPool start
]

{ #category : #accessing }
AKTDispatcher >> name [
	^ name
]

{ #category : #'as yet unclassified' }
AKTDispatcher >> processMailbox: aMailbox [

	(aMailbox isRunning or:[aMailbox isClosed]) ifTrue:[^ self].
	workerPool schedule: aMailbox task.
]

{ #category : #lifecycle }
AKTDispatcher >> stop [
	workerPool stop.
	workerPool purge
]

{ #category : #'as yet unclassified' }
AKTDispatcher >> systemDispatch: aSystemMessage receiver: aReceiver [ 
	aReceiver mailbox systemEnqueue: aSystemMessage.
	self processMailbox: aReceiver mailbox
]
