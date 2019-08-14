Class {
	#name : #AKCFixedThreadPool,
	#superclass : #AKCExecutor,
	#instVars : [
		'name',
		'taskQueue',
		'workers',
		'masterWorker',
		'maxPoolSize',
		'minPoolSize'
	],
	#category : #'Alkalin-Concurrent-Executor'
}

{ #category : #'as yet unclassified' }
AKCFixedThreadPool class >> named: aString maxPoolSize: anInteger [
	^ self named: aString maxPoolSize: anInteger minPoolSize:0
]

{ #category : #'as yet unclassified' }
AKCFixedThreadPool class >> named: aString maxPoolSize: maxInteger minPoolSize: minInteger [
	^ self basicNew
		initializeWithName: aString maxPoolSize: maxInteger minPoolSize:minInteger;
		yourself
]

{ #category : #private }
AKCFixedThreadPool >> createMasterWorker [
	masterWorker := (AKCThreadPoolWorker named: self name , ' Master Worker')
		start;
		execute: [self masterWorkerTask];
		yourself
]

{ #category : #private }
AKCFixedThreadPool >> createWorker [
	workers add:
			(AKCThreadPoolWorker
				named: self name , ' Worker #' , (workers size + 1) asString
				taskQueue: taskQueue ) start
]

{ #category : #private }
AKCFixedThreadPool >> ensureMasterWorker [
	masterWorker ifNil: [ self createMasterWorker ].
	masterWorker resume.
]

{ #category : #private }
AKCFixedThreadPool >> ensureMinPoolSize [
	[ workers size < minPoolSize ] whileTrue: [ self createWorker ]
]

{ #category : #'task running' }
AKCFixedThreadPool >> execute: aRunnableTask [
	taskQueue nextPut: aRunnableTask.
	self signalNewTask
]

{ #category : #accessing }
AKCFixedThreadPool >> hasQueuedTasks [ 
	^ self queuedTaskCount > 0 
]

{ #category : #initialization }
AKCFixedThreadPool >> initialize [ 
	super initialize.
	name := 'akc-default-executor'.
	maxPoolSize := 4.
	minPoolSize := 1.
	self start.
	
	
]

{ #category : #initialization }
AKCFixedThreadPool >> initializeWithName: aString maxPoolSize: maxInteger minPoolSize: minInteger [
	super initialize.
	name := aString.
	maxPoolSize := maxInteger.
	minPoolSize := minInteger.
	self start.
]

{ #category : #private }
AKCFixedThreadPool >> masterWorker [
	^ masterWorker 
]

{ #category : #private }
AKCFixedThreadPool >> masterWorkerTask [
[ 
	|incativeWorkers|
	
	self ensureMinPoolSize.
	
	"cleanUp inactive workers"
	incativeWorkers := workers select: [ :w | w isInactiveForTooLong ].
	incativeWorkers do:[:w|
		(workers size > minPoolSize) ifTrue:[ w stop. workers remove: w ]].
	
	"create worker if needed"
	(self hasQueuedTasks and:[
		( workers size < maxPoolSize and: [ (workers count: #isBusy) = workers size ])])
			ifTrue: [ self createWorker ].
	
	"nothing to do -> masterWorker suspend"
	 workers isEmpty ifTrue: [ masterWorker suspend ].
			
	10 milliSeconds wait.
	
] repeat 
]

{ #category : #accessing }
AKCFixedThreadPool >> maxPoolSize [
	^ maxPoolSize
]

{ #category : #accessing }
AKCFixedThreadPool >> minPoolSize [
	^ minPoolSize
]

{ #category : #accessing }
AKCFixedThreadPool >> name [
	^ name
]

{ #category : #accessing }
AKCFixedThreadPool >> queuedTaskCount [ 
	^ taskQueue size
]

{ #category : #private }
AKCFixedThreadPool >> signalNewTask [
	self ensureMasterWorker
	
]

{ #category : #'lifecycle actions' }
AKCFixedThreadPool >> start [
	workers ifNil:[workers := Set new].
	taskQueue ifNil:[taskQueue := SharedQueue new].
	self ensureMasterWorker.
]

{ #category : #'lifecycle actions' }
AKCFixedThreadPool >> stop [
	workers do:#stop.
	workers removeAll.
	taskQueue removeAll.
	masterWorker ifNotNil:[:w| w stop].
	masterWorker := nil.
]

{ #category : #private }
AKCFixedThreadPool >> workers [
	^ workers
]
