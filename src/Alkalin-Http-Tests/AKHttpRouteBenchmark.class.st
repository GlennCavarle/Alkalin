Class {
	#name : #AKHttpRouteBenchmark,
	#superclass : #TestCase,
	#category : #'Alkalin-Http-Tests'
}

{ #category : #'as yet unclassified' }
AKHttpRouteBenchmark >> route: aRoute matching100000: aRequest [
^ [ 
	1 to: 100000 do:[:i|
	aRoute matchRequest:  aRequest
	]
]
]

{ #category : #'as yet unclassified' }
AKHttpRouteBenchmark >> teaRoute: aRoute matching100000: aRequest [
^ [ 
	1 to: 100000 do:[:i|
	aRoute handleRequest: aRequest ifUnhandled: [  ]
	]
]
]

{ #category : #'as yet unclassified' }
AKHttpRouteBenchmark >> test [ 

	| route  req|
	req := AKHttpRequest fromZnRequest:(ZnRequest get:'/contacts/5d70f0fb-9fc6-4b7c-90c6-3b0e2c10512d').
	route := AKHttpRoute
				method: #GET 
				path: '/contacts/:id(int)'
				action: [:r|  ].
	(self route:route matching100000: req) timeProfile.
	"self assert: (self route:route matching100000: req)	timeToRun  < 3 seconds "
]

{ #category : #'as yet unclassified' }
AKHttpRouteBenchmark >> testTeapot [

	| route  req|
	req := ZnRequest get:'/contacts/5d70f0fb-9fc6-4b7c-90c6-3b0e2c10512d'.
	route := TeaRoute
		matcher: (TeaRequestMatcher 
			method: (TeaMethodMatcher exactly: #GET)  
			url: '/contacts/<id:IsInteger>' asTeaUrlPattern)
		action: [ :r| ]
		transformer: [ :v| ]
		port: 80.
				
	(self teaRoute:route matching100000: req) timeProfile.
	"self assert: (self teaRoute:route matching100000: req)	timeToRun  < 5 seconds 	"
]
