Class {
	#name : #AKHttpInvalidPathConstraint,
	#superclass : #Error,
	#category : #'Alkalin-Http-Routing'
}

{ #category : #signalling }
AKHttpInvalidPathConstraint class >> signalForConstraint: aString [
	^ self signal: ('Invalid placeholder constraint "{1}"' format: {aString})
]
