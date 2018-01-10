Extension { #name : #TMEnvironment }

{ #category : #'*TransactionalModifications-Calypso' }
TMEnvironment >> openCalypso [
	| navigationEnvironment |
	
	navigationEnvironment := ClyNavigationEnvironment over: (TMSystemEnvironment for: self).
	navigationEnvironment addPlugin: TMSystemEnvironmentPlugin new.
	
	ClyFullBrowser openOn: navigationEnvironment.
]
