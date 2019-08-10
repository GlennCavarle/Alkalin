Class {
	#name : #AKHttpPathConstraintUuid,
	#superclass : #AKHttpPathConstraint,
	#category : #'Alkalin-Http-Routing'
}

{ #category : #converting }
AKHttpPathConstraintUuid class >> converter [
	^ [ :str| UUID fromString: str]
]

{ #category : #converting }
AKHttpPathConstraintUuid class >> regexString [
	^ '([a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}){1}'
]

{ #category : #accessing }
AKHttpPathConstraintUuid class >> type [
	^ #uuid
]
