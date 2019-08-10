Class {
	#name : #AKHttpMatcher,
	#superclass : #Object,
	#category : #'Alkalin-Http-Routing'
}

{ #category : #testing }
AKHttpMatcher >> matchRequest: anHttpRequest [
	self subclassResponsibility 
]
