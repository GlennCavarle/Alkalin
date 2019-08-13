Class {
	#name : #AKTPromiseActorRef,
	#superclass : #AKTAbstractActorRef,
	#instVars : [
		'future'
	],
	#category : #'Alkalin-Actor-Actor'
}

{ #category : #accessing }
AKTPromiseActorRef >> ask: aMessage sender: aSender [
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
	future := AKCFuture new 
]

{ #category : #accessing }
AKTPromiseActorRef >> tell: aMessage sender: aSender [
	future completeWith: aMessage
]
