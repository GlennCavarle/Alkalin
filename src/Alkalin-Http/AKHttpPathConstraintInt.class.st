Class {
	#name : #AKHttpPathConstraintInt,
	#superclass : #AKHttpPathConstraint,
	#category : #'Alkalin-Http-Routing'
}

{ #category : #converting }
AKHttpPathConstraintInt class >> converter [
	^ [ :str | str asInteger ] 
]

{ #category : #converting }
AKHttpPathConstraintInt class >> regexString [
	^ '-?\d+'
]

{ #category : #accessing }
AKHttpPathConstraintInt class >> type [
	^ #int
]
