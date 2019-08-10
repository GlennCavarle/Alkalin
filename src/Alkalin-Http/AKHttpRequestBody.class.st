Class {
	#name : #AKHttpRequestBody,
	#superclass : #Object,
	#category : #'Alkalin-Http-Message'
}

{ #category : #'instance creation' }
AKHttpRequestBody class >> fromZnEntity: aZnEntity [
		
	^ AKMod match: aZnEntity cases: [ :m |  m
				is: ZnStringEntity
					andHas: {(#contentType -> ZnMimeType applicationJson)}
					do: [:e| AKHttpRequestBodyJson fromString: e string];
				is: ZnStringEntity
					andHas: {(#contentType -> ZnMimeType applicationXml)}
					do: [:e| AKHttpRequestBodyXml fromString: e string];
				is: ZnStringEntity
					andHas: {(#contentType -> ZnMimeType textPlain)}
					do: [:e| AKHttpRequestBodyText fromString: e string];
				is: ZnApplicationFormUrlEncodedEntity 
					do: [:e| AKHttpRequestBodyFormUrlEncoded fields: e fields ];
				is: ZnMultiPartFormDataEntity
					do: [:e| AKHttpRequestBodyMultipartFormData parts: e parts ];
				is: UndefinedObject 
					do: [:e| AKHttpRequestBodyNone new];
				default: [:e| AKHttpRequestBodyRaw fromContents: e contents ] ]
]
