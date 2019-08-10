Class {
	#name : #AKHttpPathConstraintWord,
	#superclass : #AKHttpPathConstraint,
	#category : #'Alkalin-Http-Routing'
}

{ #category : #converting }
AKHttpPathConstraintWord class >> converter [
	^ [ :str | str asString]
]

{ #category : #converting }
AKHttpPathConstraintWord class >> regexString [
	^ '\w+'
]

{ #category : #accessing }
AKHttpPathConstraintWord class >> type [
	^ #word
]
