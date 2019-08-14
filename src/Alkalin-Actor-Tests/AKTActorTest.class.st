Class {
	#name : #AKTActorTest,
	#superclass : #TestCase,
	#category : #'Alkalin-Actor-Tests'
}

{ #category : #tests }
AKTActorTest >> test [
	| system actorRef f |
	system := AKTSystem named: 'test-system'.
	actorRef := system createActor: [ AKTTestingActor new ] named: 'test-actor'.
	
	f := (actorRef ? 'hello').
	
	f onSuccessDo: [ :r|
		self assert: true.
		Transcript crShow: r.
		system terminate 
	].

	f waitForCompletion: 2 seconds.
	self assert: f isCompleted
]
