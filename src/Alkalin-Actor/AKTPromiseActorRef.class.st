Class {
	#name : #AKTPromiseActorRef,
	#superclass : #Object,
	#instVars : [
		'future'
	],
	#category : #'Alkalin-Actor-Actor'
}

{ #category : #accessing }
AKTPromiseActorRef >> ask: aMessage [
	future
		deployFailure: (Error new messageText: 'PromiseActorRef cannot be asked')
]

{ #category : #accessing }
AKTPromiseActorRef >> future [
	^ future
]

{ #category : #initialization }
AKTPromiseActorRef >> initialize [ 
	super initialize.
	future := TKTFuture new 
]

{ #category : #accessing }
AKTPromiseActorRef >> tell: aMessage [
	future deploySuccess: aMessage
]
