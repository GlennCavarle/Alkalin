Class {
	#name : #AKTTestingActor,
	#superclass : #Object,
	#traits : 'TAKTActor',
	#classTraits : 'TAKTActor classTrait',
	#category : #'Alkalin-Actor-Tests'
}

{ #category : #accessing }
AKTTestingActor >> receiveMessage: aMessage [
	Transcript crShow: aMessage.
	self sender ! 'ok'
]
