Class {
	#name : #AKMMatchCase,
	#superclass : #Object,
	#instVars : [
		'condition',
		'block'
	],
	#category : #'Alkalin-Monad'
}

{ #category : #'as yet unclassified' }
AKMMatchCase class >> condition: aCondition do: aBlock [
	^ self new condition:aCondition; block: aBlock
]

{ #category : #'as yet unclassified' }
AKMMatchCase class >> has: anAssocArray do: aBlock [
	|fieldDict|
	fieldDict := anAssocArray asDictionary.
	^ self condition: [ :t |  t isNotNil and: [ fieldDict associations
						allSatisfy: [ :assoc | (t perform: assoc key) = assoc value ] ] ]
		do: aBlock
]

{ #category : #'as yet unclassified' }
AKMMatchCase class >> is: aClass andHas: anAssocArray do: aBlock [
	|isCase hasCase|
	isCase := (self is:aClass do: nil).
	hasCase := (self has: anAssocArray do: nil).
	^ self condition: [:t| (isCase condition value:t) and: (hasCase condition value:t)] do: aBlock
]

{ #category : #'as yet unclassified' }
AKMMatchCase class >> is: aClass do: aBlock [
	(self environment includes: aClass) ifFalse: [AKMMatchError signal:'class does not exist'].
	^ self condition: [ :t | t isKindOf: aClass ] do: aBlock
]

{ #category : #accessing }
AKMMatchCase >> block [
	^ block
]

{ #category : #accessing }
AKMMatchCase >> block: anObject [
	block := anObject
]

{ #category : #accessing }
AKMMatchCase >> condition [
	^ condition
]

{ #category : #accessing }
AKMMatchCase >> condition: anObject [
	condition := anObject
]
