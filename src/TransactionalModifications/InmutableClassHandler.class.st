Class {
	#name : #InmutableClassHandler,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : #'TransactionalModifications-Wrappers'
}

{ #category : #'instance creation' }
InmutableClassHandler class >> for: anInmutableEnvironment [
	^ self new
		environment: anInmutableEnvironment;
		yourself
]

{ #category : #accessing }
InmutableClassHandler >> environment [
	^ environment
]

{ #category : #accessing }
InmutableClassHandler >> environment: anObject [
	environment := anObject
]

{ #category : #handling }
InmutableClassHandler >> handleClassSide: aRealClass [
	^ environment metaclassNamed: aRealClass name
]

{ #category : #handling }
InmutableClassHandler >> handleInstanceMessage: aMessage toTarget: anObject [
	'handleInstanceMessage:' logCr.
	aMessage selector logCr.
	
	
	1haltIf: [ aMessage selector = #setName: ].
	
		
	"^ aMessage sendTo: anObject.
"
]

{ #category : #handling }
InmutableClassHandler >> handleMessage: aMessage toTarget: anObject [
	aMessage selector = #superclass
		ifTrue: [ ^ self handleSuperclass: anObject ].
	(#(#classSide class) includes: aMessage selector)
		ifTrue: [ ^ self handleClassSide: anObject ].

	aMessage selector = #subclasses
		ifTrue: [ ^ self handleSubclasses: anObject ].

	aMessage selector = #withAllSuperclassesDo:
		ifTrue: [ ^ anObject withAllSuperclassesDo: aMessage arguments first ].

	aMessage selector = #allSubclassesDo:
		ifTrue: [ ^ anObject allSubclassesDo: aMessage arguments first ].

	(self readOnlySelectors includes: aMessage selector)
		ifTrue: [ self error: 'Trying to modify a read only class:' , aMessage selector ].

	^ aMessage sendTo: anObject
]

{ #category : #handling }
InmutableClassHandler >> handleSubclasses: aRealClass [
	| original |
	original := aRealClass subclasses.
	^ original collect: [ :e | environment classNamed: e name ]
]

{ #category : #handling }
InmutableClassHandler >> handleSuperclass: aRealClass [
	aRealClass superclass ifNil: [ ^ nil ].
	^ environment classNamed: (aRealClass superclass name)
]

{ #category : #handling }
InmutableClassHandler >> readOnlySelectors [
	^ #(#setName: #weakSubclass:uses:instanceVariableNames:classVariableNames:category: #addSelector:withMethod:notifying: #addSharedPool: #subclass:uses:instanceVariableNames:classVariableNames:package: #printSubclassesOn:level: #removeProtocol: #sharing: #newInstanceFrom:variable:size: #groupRefactoring: #noteCompilationOf:meta: #variableWordSubclass:instanceVariableNames:classVariableNames:package: #newAnonymousSubclass #subclass:uses: #copyMethodDictionaryFrom: #removeSelectorSilently: #instVarRefactoring: #removeProperty: #methodRefactoring: #comment:stamp: #subclass:uses:layout:slots:classVariables:category: #variableWordSubclass:uses:instanceVariableNames:classVariableNames:category: #removeSharedPool: #compileAll #subclass:uses:slots:classVariables:category: #weakSubclass:instanceVariableNames:classVariableNames:poolDictionaries:category: #classComment:stamp: #subclasses #becomeUncompact #copyCategory:from:classified: #compile:classified:withStamp:notifying:logSource: #duringTestCompileSilently:storeSource:classified: #rename: #variableSubclass:uses:instanceVariableNames:classVariableNames:category: #copyAll:from: #initialize #setFormat: #immediateSubclass:uses:instanceVariableNames:classVariableNames:poolDictionaries:package: #compile:classified:withStamp:notifying: #category: #subclass:instanceVariableNames:classVariableNames:package: #packageFromOrganizer: #copyAll:from:classified: #subclass:slots:classVariables:poolDictionaries:category: #weakSubclass:instanceVariableNames:classVariableNames:poolDictionaries:package: #logMethodSource:forMethod:inCategory:withStamp: #innerBindingOf: #printCategoryChunk:on:withStamp:priorMethod: #subclass:uses:slots:classVariables:poolDictionaries:category: #unload #subclasses: #compile:classified:notifying: #refactoringMenu: #removeSubclass: #variableByteSubclass:instanceVariableNames:classVariableNames:poolDictionaries:category: #recompile:from: #populateCBMenu: #declareClassVariables: #superclass: #immediateSubclass:instanceVariableNames:classVariableNames:package: #addAndClassifySelector:withMethod:inProtocol:notifying: #withAllSuperAndSubclassesDo: #addSelector:withMethod: #noteAddedSelector:meta: #methodDictionary: #ephemeronSubclass:instanceVariableNames:classVariableNames:package: #users #spotterSuperclassesFor: #addCategory:before: #allSubclasses #variableWordSubclass:uses:instanceVariableNames:classVariableNames:poolDictionaries:category: #organization: #compile:notifying: #usesSpecialClassVariables #notifyOfRecategorizedSelector:from:to: #allInstVarNamesEverywhere #compileSilently:classified: #subclass:instanceVariableNames:classVariableNames:poolDictionaries:category: #compress #subclass:uses:layout:slots:classVariables:poolDictionaries:category: #classBindingOf: #weakSubclass:uses:instanceVariableNames:classVariableNames:poolDictionaries:category: #selectSuperclasses: #copyAllCategoriesFrom: #setTraitComposition: #variableSubclass:uses:instanceVariableNames:classVariableNames:package: #copyCategory:from: #instVarNameForIndex: #removeProperty:ifAbsent: #subclass:instanceVariableNames: #propertyAt:put: #untagFrom: #weakSubclass:instanceVariableNames:classVariableNames:package: #basicRemoveSelector: #variableByteSubclass:uses:instanceVariableNames:classVariableNames:poolDictionaries:category: #cleanUp #compile: #banLevelCandidates #compile:classified: #duplicateClassWithNewName: #selectSubclasses: #addClassSlot: #duringTestCompileSilently: #withAllSubAndSuperclassesDo: #renameSilently: #recompile: #allSubclassesWithLevelDo:startingLevel: #emptyMethodDictionary #allSubclassesDo: #ephemeronSubclass:instanceVariableNames:classVariableNames:poolDictionaries:category: #printSubclassesOn:level:filter: #sendNodes #basicAddSelector:withMethod: #variableSubclass:instanceVariableNames:classVariableNames:poolDictionaries:category: #writeClassVariableNamed:value: #copy:from:classified: #shutDown: #removePropertiesIfEmpty #newSubclass #banChecksForValidation #environment: #instanceVariableWriteNodes #slotDefinitionString #immediateSubclass:instanceVariableNames:classVariableNames:poolDictionaries:package: #sharedPools: #initializeSlots: #name: #noteCompilationOfMethod:meta: #realClass #sourceCodeRefactoring: #removeMethodTag: #fileOutChangedMessages:on: #commentsIn: #superclass:methodDictionary:format: #varRefactoringSubMenu: #duringTestCompileSilently:storeSource: #codeRewritingClass: #subclass: #variableWordSubclass:uses:instanceVariableNames:classVariableNames:package: #withAllSubclasses #subclass:layout:slots:classVariables:category: #addClassVarNamed: #obsolete #subclass:instanceVariableNames:classVariableNames:poolDictionaries:package: #binding #variableSubclass:instanceVariableNames:classVariableNames:category: #addInstVarNamed: #subclass:slots:classVariables:category: #addObsoleteSubclass: #reformatAll #indexIfCompact #evaluate: #addSelectorSilently:withMethod: #removeInstVarNamed: #spotterSubclassesFor: #variableSubclass:uses:instanceVariableNames:classVariableNames:poolDictionaries:category: #classPool: #subclass:layout:slots:classVariables:poolDictionaries:category: #recompile #removeFromSystem: #variableWordSubclass:instanceVariableNames:classVariableNames:category: #variableByteSubclass:instanceVariableNames:classVariableNames:category: #cleanUp: #environment #variableWordSubclass:instanceVariableNames:classVariableNames:poolDictionaries:package: #removeFromSystem #addToComposition: #weakSubclass:uses:instanceVariableNames:classVariableNames:poolDictionaries:package: #addClassVariable: #bindingOf: #withAllSubclassesDo: #subclass:instanceVariableNames:classVariableNames:category: #variableByteSubclass:instanceVariableNames:classVariableNames:package: #reorganize #compileSilently:classified:notifying: #variableSubclass:uses:instanceVariableNames:classVariableNames:poolDictionaries:package: #classCommentBlank #basicOrganization: #removeClassVarNamed:interactive: #notifyRepackage:method:oldProtocol:newProtocol: #commentStamp: #compileAllFrom: #allSuperclassesIncluding: #compileSilently: #variableWordSubclass:instanceVariableNames:classVariableNames:poolDictionaries:category: #becomeCompact #renameMethodAllItem: #withAllSuperclassesDo: #superclass:layout: #removeFromSystemUnlogged #instVarIndexFor:ifAbsent: #variableSubclass:instanceVariableNames:classVariableNames:package: #subclass:uses:instanceVariableNames:classVariableNames:poolDictionaries:package: #basicCategory: #allSuperclassesDo: #ban: #classComment: #immediateSubclass:uses:instanceVariableNames:classVariableNames:package: #weakSubclass:instanceVariableNames:classVariableNames:category: #classSide #zapOrganization #deepCopy #removeClassVariable: #baseComposition #packageOrganizer #becomeCompactSimplyAt: #removeFromChanges #addSubclass: #addSlot: #superclass:withLayoutType:slots: #tagWith: #traits #variableByteSubclass:uses:instanceVariableNames:classVariableNames:category: #fileOutMethod: #methodDict: #removeSelector: #variableSubclass:instanceVariableNames:classVariableNames:poolDictionaries:package: #removeClassVarNamed: #copy:from: #addMethodTag: #duringTestCompileSilently:classified: #removeSlot: #subclass:uses:instanceVariableNames:classVariableNames:category: #subclass:uses:instanceVariableNames:classVariableNames:poolDictionaries:category: #subclassesDo: #traitComposition #variableWordSubclass:uses:instanceVariableNames:classVariableNames:poolDictionaries:package: #withAllSuperclasses #weakSubclass:uses:instanceVariableNames:classVariableNames:package: #updateInstances:from:isMeta:)
]
