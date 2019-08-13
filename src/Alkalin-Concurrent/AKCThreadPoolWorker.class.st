Class {
	#name : #AKCThreadPoolWorker,
	#superclass : #Object,
	#instVars : [
		'name',
		'process',
		'inactivityTimeout',
		'taskQueue',
		'lastActivityTime',
		'busy'
	],
	#category : #'Alkalin-Concurrent-Executor'
}

{ #category : #'instance creation' }
AKCThreadPoolWorker class >> named: aString [
	^ self named: aString taskQueue: SharedQueue new
]

{ #category : #'instance creation' }
AKCThreadPoolWorker class >> named: aString taskQueue: aTaskQueue [
	^ self basicNew
		initializeWithName: aString taskQueue: aTaskQueue;
		yourself
]

{ #category : #'task running' }
AKCThreadPoolWorker >> execute: aTask [
	self isTerminated ifTrue:[Error signal: 'Worker already terminated'].
	taskQueue nextPut: aTask
]

{ #category : #private }
AKCThreadPoolWorker >> handleException: anError [
	anError signal.
	
]

{ #category : #initialization }
AKCThreadPoolWorker >> initialize [ 
	super initialize.
	inactivityTimeout := 1 seconds.
]

{ #category : #initialization }
AKCThreadPoolWorker >> initializeWithName: aString taskQueue: aTaskQueue [
	self  initialize.
	name := aString.
	taskQueue := aTaskQueue
]

{ #category : #'private testing' }
AKCThreadPoolWorker >> isBusy [
	^ busy
]

{ #category : #'private testing' }
AKCThreadPoolWorker >> isInactiveForTooLong [
	^ busy not and:[ DateAndTime now > (lastActivityTime + inactivityTimeout)]
]

{ #category : #'private testing' }
AKCThreadPoolWorker >> isRunning [
	^ self isTerminated not
]

{ #category : #'private testing' }
AKCThreadPoolWorker >> isTerminated [
	^ process isNil or: [ process isTerminated ]
]

{ #category : #accessing }
AKCThreadPoolWorker >> name [
	^ name
]

{ #category : #'lifecycle actions' }
AKCThreadPoolWorker >> resume [
	(self isBusy or: [ self isTerminated ]) ifTrue: [ ^ self ].
	process resume
]

{ #category : #'lifecycle actions' }
AKCThreadPoolWorker >> start [
	self isRunning ifTrue:[^ self].
	lastActivityTime := DateAndTime now.
	busy := false.
	process := [ self taskLoop ]
		forkAt: Processor systemBackgroundPriority
		named: self name
]

{ #category : #'lifecycle actions' }
AKCThreadPoolWorker >> stop [
	process ifNotNil: [
		process terminate.
		process := nil ]
]

{ #category : #'lifecycle actions' }
AKCThreadPoolWorker >> suspend [
	(self isRunning ) ifFalse:[^ self].
	busy := false.
	process suspend.
]

{ #category : #private }
AKCThreadPoolWorker >> taskLoop [
	[ 
		| task |
		task := taskQueue next.
		busy := true.
		lastActivityTime := DateAndTime now.
		[ task value ] on: Error do: [ :error | self handleException: error ].
		busy := false.
	] repeat
]
