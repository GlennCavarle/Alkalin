Class {
	#name : #AKHttpRequestBodyFormUrlEncoded,
	#superclass : #AKHttpRequestBody,
	#instVars : [
		'fields'
	],
	#category : #'Alkalin-Http-Message'
}

{ #category : #accessing }
AKHttpRequestBodyFormUrlEncoded class >> fields: aDict [
	^ self new initializeWithFields: aDict
]

{ #category : #accessing }
AKHttpRequestBodyFormUrlEncoded >> fields [
	^ fields
]

{ #category : #initialization }
AKHttpRequestBodyFormUrlEncoded >> initializeWithFields: aDict [
	fields := aDict
]
