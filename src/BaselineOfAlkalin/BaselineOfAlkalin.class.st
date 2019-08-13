Class {
	#name : #BaselineOfAlkalin,
	#superclass : #BaselineOf,
	#category : #BaselineOfAlkalin
}

{ #category : #baselines }
BaselineOfAlkalin >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			
			spec 
				package: #'Alkalin-Actor' with: [ spec requires: #(#'Alkalin-Concurrent' #'Alkalin-Monad') ];
				package: #'Alkalin-Concurrent' ;
				package: #'Alkalin-Http' ;
				package: #'Alkalin-Monad'
		]
]
