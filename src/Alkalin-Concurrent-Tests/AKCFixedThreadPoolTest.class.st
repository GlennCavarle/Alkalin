Class {
	#name : #AKCFixedThreadPoolTest,
	#superclass : #AKCTestCase,
	#instVars : [
		'threadPool'
	],
	#category : #'Alkalin-Concurrent-Tests'
}

{ #category : #tests }
AKCFixedThreadPoolTest >> garbageCollectAndWait [
	5
		timesRepeat: [ Smalltalk garbageCollect.
			100 milliSeconds wait ].
	1 second wait.
	
]

{ #category : #tests }
AKCFixedThreadPoolTest >> setUp [
	threadPool := AKCFixedThreadPool named: 'test-pool' maxPoolSize: 4
]

{ #category : #tests }
AKCFixedThreadPoolTest >> tearDown [
	threadPool stop
]

{ #category : #tests }
AKCFixedThreadPoolTest >> testInitialState [

self assert: threadPool maxPoolSize equals: 4.
self assert: threadPool name equals: 'test-pool'.
self assert: threadPool queuedTaskCount equals: 0.
self assert: threadPool hasQueuedTasks not.
self assert: threadPool masterWorker isNotNil.
self assert: threadPool masterWorker isRunning.
self assert: threadPool workers isEmpty.
threadPool stop.
self assert: threadPool masterWorker isNil.
]

{ #category : #tests }
AKCFixedThreadPoolTest >> testStopStart [

threadPool stop.
self assert: threadPool masterWorker isNil.
threadPool start.
self assert: threadPool masterWorker isRunning.
]

{ #category : #tests }
AKCFixedThreadPoolTest >> testWorkerPoolResizing [

5 timesRepeat: [threadPool execute:[100 milliSecond wait]].

"wait for thread creation"
200 milliSecond wait.
self assert: threadPool workers size equals: 4.

"wait for inactivity timeout"
1 second wait.
self assert: threadPool workers size equals: 0.


]
