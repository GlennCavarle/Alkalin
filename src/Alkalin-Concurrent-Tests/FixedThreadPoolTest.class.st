Class {
	#name : #FixedThreadPoolTest,
	#superclass : #TestCase,
	#category : #'Alkalin-Concurrent-Tests'
}

{ #category : #tests }
FixedThreadPoolTest >> test [
|pool|
pool := AKCFixedThreadPool named: 'test-pool' maxPoolSize: 4.

5 timesRepeat: [pool execute:[100 milliSecond wait]].

"wait for thread creation"
200 milliSecond wait.
self assert: pool workers size equals: 4.

"wait for inactivity timeout"
1 second wait.
self assert: pool workers size equals: 0.

pool stop.

]

{ #category : #tests }
FixedThreadPoolTest >> testInitialState [
|pool|
pool := AKCFixedThreadPool named: 'test-pool' maxPoolSize: 4.

self assert: pool maxPoolSize equals: 4.
self assert: pool name equals: 'test-pool'.
self assert: pool queuedTaskCount equals: 0.
self assert: pool hasQueuedTasks not.
self assert: pool masterWorker isNotNil.
self assert: pool masterWorker isRunning.
self assert: pool workers isEmpty.

pool stop.
self assert: pool masterWorker isNil.
]
