Class {
	#name : #AKTActorTest,
	#superclass : #TestCase,
	#category : #'Alkalin-Actor-Tests'
}

{ #category : #tests }
AKTActorTest >> test [
	| system actorRef |
	system := AKTSystem named: 'test-system'.
	actorRef := system createActor: [ AKTActor new ] named: 'test-actor'.
	(actorRef ask: 'hello') onSuccessDo: [ :r|
		self assert: true.
		system terminate 
	]
]
