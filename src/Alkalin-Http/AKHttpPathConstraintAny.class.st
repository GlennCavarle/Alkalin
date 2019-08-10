Class {
	#name : #AKHttpPathConstraintAny,
	#superclass : #AKHttpPathConstraint,
	#category : #'Alkalin-Http-Routing'
}

{ #category : #converting }
AKHttpPathConstraintAny class >> converter [
	^ [:str | str asString]
]

{ #category : #converting }
AKHttpPathConstraintAny class >> regexString [
	^ '.+'
]

{ #category : #converting }
AKHttpPathConstraintAny class >> type [
	^ #any
]
