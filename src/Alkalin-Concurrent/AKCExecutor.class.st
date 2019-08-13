Class {
	#name : #AKCExecutor,
	#superclass : #Object,
	#classInstVars : [
		'DefaultExecutor'
	],
	#category : #'Alkalin-Concurrent-Executor'
}

{ #category : #'as yet unclassified' }
AKCExecutor class >> defaultExecutor [
	^ DefaultExecutor
		ifNil: [ DefaultExecutor := AKCFixedThreadPool
				named: 'ak-default'
				maxPoolSize: 4
				minPoolSize: 1 ]
]

{ #category : #'as yet unclassified' }
AKCExecutor class >> resetDefaultExecutor [
	DefaultExecutor ifNotNil:[:e| e stop].
	DefaultExecutor := nil
]
