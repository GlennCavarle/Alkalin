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
				baseline: 'TaskIt'
				with: [ spec repository: 'github://sbragagnolo/taskit' ].
				
			spec 
				package: #'Alkalin-Actor' with: [ spec requires: #(#'TaskIt' #'Alkalin-Monad') ];
				package: #'Alkalin-Http' ;
				package: #'Alkalin-Monad'
		]
]
