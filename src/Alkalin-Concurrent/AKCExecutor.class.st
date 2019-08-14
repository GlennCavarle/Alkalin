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
		ifNil: [ DefaultExecutor := AKCFixedThreadPool new ]
]

{ #category : #'as yet unclassified' }
AKCExecutor class >> resetDefaultExecutor [
	DefaultExecutor ifNotNil:[:e| e stop].
	DefaultExecutor := nil
]
