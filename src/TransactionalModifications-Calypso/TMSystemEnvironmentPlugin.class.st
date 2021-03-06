Class {
	#name : #TMSystemEnvironmentPlugin,
	#superclass : #ClyEnvironmentPlugin,
	#category : #'TransactionalModifications-Calypso'
}

{ #category : #testing }
TMSystemEnvironmentPlugin class >> isAutoActivated [
	^ true
]

{ #category : #testing }
TMSystemEnvironmentPlugin class >> isAutoActivatedOn: aNavigationEnvironment [
	self halt.
	^ false
]

{ #category : #packages }
TMSystemEnvironmentPlugin >> checkPackageHasClassGroups: aPackage [

	| providers packageScope |
	packageScope := ClyPackageScope of: aPackage in: environment.
	environment
		pluginsDo: [ :plugin | 
			providers := plugin collectClassGroupProviders.
			providers
				do: [ :each | each classGroupsIn: packageScope do: [ :group | ^ true ] ] ].
	^ false
]

{ #category : #classes }
TMSystemEnvironmentPlugin >> collectClassGroupProviders [

	^ #()
]

{ #category : #classes }
TMSystemEnvironmentPlugin >> collectMetadataOfClasses: aClyExtensionLastSortedClasses [ 

]

{ #category : #methods }
TMSystemEnvironmentPlugin >> collectMetadataOfMethodGroups: aClySortedQueryResult [ 

]

{ #category : #methods }
TMSystemEnvironmentPlugin >> collectMetadataOfMethods: aClySortedQueryResult [ 

]

{ #category : #packages }
TMSystemEnvironmentPlugin >> collectMetadataOfPackages: aClySortedQueryResult [ 
	
]

{ #category : #methods }
TMSystemEnvironmentPlugin >> collectMethodGroupProviders [
	
	^ #()
]

{ #category : #classes }
TMSystemEnvironmentPlugin >> decorateBrowserItem: anItem ofClass: aClass [

	anItem ensureSystemDefinition: [ ClyClassDefinitionProperty of: aClass ].
	aClass localSelectors ifNotEmpty: [ anItem markWithChildrenOf: ClyMethod ].

]

{ #category : #decorating }
TMSystemEnvironmentPlugin >> decorateBrowserItem: aClyBrowserItem ofMethod: aCollection [ 
	
]

{ #category : #methods }
TMSystemEnvironmentPlugin >> decorateBrowserItem: aClyBrowserItem ofMethodGroup: aClyExternalPackageMethodGroup [ 

]

{ #category : #packages }
TMSystemEnvironmentPlugin >> decorateBrowserItem: aBrowserItem ofPackage: aPackage [

	aPackage classes ifNotEmpty: [ aBrowserItem markWithChildrenOf: ClyClass ].

	(self checkPackageHasClassGroups: aPackage)
		ifTrue: [ aBrowserItem markWithChildrenOf: ClyClassGroup ]
]

{ #category : #critics }
TMSystemEnvironmentPlugin >> prepareBrowserItem: aClyBrowserItem ofCritique: aReTrivialCritique [ 

]

{ #category : #classes }
TMSystemEnvironmentPlugin >> resolveMetadataOfCritiques: aClySortedCritiques [ 

]
