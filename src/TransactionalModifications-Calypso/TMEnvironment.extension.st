Extension { #name : #TMEnvironment }

{ #category : #'*TransactionalModifications-Calypso' }
TMEnvironment >> openCalypso [
	| navigationEnvironment |
	
	navigationEnvironment := ClyNavigationEnvironment over: (TMSystemEnvironment for: self).
	navigationEnvironment addPlugin: TMSystemEnvironmentPlugin new.
	navigationEnvironment addPlugin: ClyCriticEnvironmentPlugin new.
	navigationEnvironment attachToSystem.
	
	ClyFullBrowser openOn: navigationEnvironment.
]
