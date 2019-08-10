Class {
	#name : #AKMMatch,
	#superclass : #Object,
	#instVars : [
		'cases',
		'default'
	],
	#category : #'Alkalin-Monad'
}

{ #category : #accessing }
AKMMatch class >> target: aTarget cases: aBlock [
	^ (aBlock value: self new ) match:aTarget
]

{ #category : #case }
AKMMatch >> default: aBlock [ 
	default := (AKMMatchCase condition:[true] do:aBlock)
]

{ #category : #case }
AKMMatch >> has: anAssocArray do: aBlock [
	cases add: (AKMMatchCase has: anAssocArray do: aBlock)
]

{ #category : #initialization }
AKMMatch >> initialize [
	super initialize.
	cases := OrderedCollection new.
	default := [AKMMatchError signal:'default case is not defined'].
]

{ #category : #case }
AKMMatch >> is: aClass andHas: anAssocArray do: aBlock [ 
	cases add: (AKMMatchCase is: aClass andHas: anAssocArray do: aBlock )
]

{ #category : #case }
AKMMatch >> is: aClass do: aBlock [ 
	cases add: (AKMMatchCase is: aClass do: aBlock )
]

{ #category : #execution }
AKMMatch >> match: aTarget [
	
	cases do:[:c| (c condition value: aTarget) ifTrue:[^ c block cull: aTarget]].
	^ default block cull: aTarget
]
