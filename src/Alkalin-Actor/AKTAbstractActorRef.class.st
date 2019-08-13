Class {
	#name : #AKTAbstractActorRef,
	#superclass : #Object,
	#category : #'Alkalin-Actor-Actor'
}

{ #category : #instructions }
AKTAbstractActorRef >> ! aMessage [ 
	<return:#self>
	^ self tell: aMessage
	
]

{ #category : #instructions }
AKTAbstractActorRef >> ? aMessage [ 
	<return:#Future>
	^ self ask: aMessage
	
]

{ #category : #instructions }
AKTAbstractActorRef >> ask: aMessage [
<return:#Future>
	^ self ask: aMessage sender: nil
]

{ #category : #instructions }
AKTAbstractActorRef >> ask: aMessage sender: aSender [
	<return:#Future>
	self subclassResponsibility 
]

{ #category : #accessing }
AKTAbstractActorRef >> stop [
]

{ #category : #instructions }
AKTAbstractActorRef >> tell: aMessage [ 
	<return:#self>
	^ self tell: aMessage sender: nil.
	
]

{ #category : #instructions }
AKTAbstractActorRef >> tell: aMessage sender: aSender [
	<return:#self>
	self subclassResponsibility 
]
