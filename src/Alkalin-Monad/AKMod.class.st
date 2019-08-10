Class {
	#name : #AKMod,
	#superclass : #Object,
	#category : #'Alkalin-Monad'
}

{ #category : #'as yet unclassified' }
AKMod class >> match: anObject cases: aBlock [
	^ AKMMatch target: anObject cases: aBlock
]
