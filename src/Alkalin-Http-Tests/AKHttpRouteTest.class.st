Class {
	#name : #AKHttpRouteTest,
	#superclass : #TestCase,
	#category : #'Alkalin-Http-Tests'
}

{ #category : #tests }
AKHttpRouteTest >> testRouteMatching [
	| route |
	route := AKHttpRoute
		method: #GET
		path: '/test/:id(int)'
		action: [:r|].
	
	self assert: (route matchRequest: (AKHttpRequest fromZnRequest:(ZnRequest get:'/test/42'))).
	self assert: (route matchRequest: (AKHttpRequest fromZnRequest:(ZnRequest get:'/test/aString'))) not.
	self assert: (route matchRequest: (AKHttpRequest fromZnRequest:(ZnRequest post:'/test/42'))) not
]

{ #category : #tests }
AKHttpRouteTest >> testRouteMatchingWithMultipleMethods [
	| route |
	route := AKHttpRoute
		methods: #(GET POST)
		path: '/test/:id(int)'
		action: [].
	
	self assert: (route matchRequest: (AKHttpRequest fromZnRequest:(ZnRequest get:'/test/42'))).
	self assert: (route matchRequest: (AKHttpRequest fromZnRequest:(ZnRequest post:'/test/42')))
]

{ #category : #tests }
AKHttpRouteTest >> testRoutePathToName [
	self assert: (AKHttpRoute pathToName: '/') equals: #_.
	self assert: (AKHttpRoute pathToName: '/test/route') equals: #_test_route.
	self assert: (AKHttpRoute pathToName: '/test/route/') equals: #_test_route_.
	self assert: (AKHttpRoute pathToName: '/test/route/:arg(int)') equals: #_test_route__arg_int_.
	self assert: (AKHttpRoute pathToName: '/test/route/:arg(\d+[A-Z]{3})') equals: #_test_route__arg__d__A_Z__3__.
	"Warning : some route can have the same name for different regex expressions"
	self assert: (AKHttpRoute pathToName: '/test/route/:arg(.d*[A-Z][3])') equals: #_test_route__arg__d__A_Z__3__
]
