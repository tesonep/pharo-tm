Class {
	#name : #TMEnvironment,
	#superclass : #Object,
	#instVars : [
		'classes',
		'parent',
		'singlePackage'
	],
	#category : #'TransactionalModifications-Core'
}

{ #category : #classes }
TMEnvironment >> allClasses [

	^ classes values
]

{ #category : #accessing }
TMEnvironment >> associationAt: aName ifAbsent: aBlock [

	^ classes associationAt: aName ifAbsent: aBlock
]

{ #category : #accessing }
TMEnvironment >> at: aName ifAbsent: aBlock [

	^ classes at: aName ifAbsent: aBlock
]

{ #category : #accessing }
TMEnvironment >> at: aName put: anObject [

	anObject isBehavior ifTrue: [ ^ self installClass: anObject ].
	
	self assert: 'We should not be here'.
	

]

{ #category : #classes }
TMEnvironment >> categorizeClass: aClass [
 
	singlePackage importClass: aClass.

]

{ #category : #classes }
TMEnvironment >> classNamed: aName [
 
	^ classes at: aName ifAbsent: [ parent classNamed: aName ]
]

{ #category : #compiling }
TMEnvironment >> compile: sourceCode inClassNamed: aClassName [ 

	^ (self classNamed: aClassName) compile: sourceCode. 
]

{ #category : #'classes - slots' }
TMEnvironment >> createSlots: slotDefinitions [
	
	^ slotDefinitions collect: [ :aDef |
		aDef name asSymbol => (self classNamed: aDef typeName asSymbol)
	].
]

{ #category : #classes }
TMEnvironment >> defineClass: aDefinition [

	^ TMClassInstaller
		make: [ :builder | 
			builder
				buildEnvironment: ShGlobalsEnvironment new;
				environment: self;
				name: aDefinition className;
				superclassName: aDefinition superclassName;
				slots: (self createSlots: aDefinition slots);
				category: aDefinition packageName ]
]

{ #category : #accessing }
TMEnvironment >> description [
	

	^ self asString
]

{ #category : #classes }
TMEnvironment >> hasClassNamed: aName [ 

	^ (classes includesKey: aName) or: [ parent hasClassNamed: aName ]
]

{ #category : #initialization }
TMEnvironment >> initialize [
	super initialize.

	classes := Dictionary new.
	parent := TMImageEnvironment new.

	singlePackage := TMDummyPackage new
		tmEnvironment: self;
		name: 'AllClasses';
		yourself
]

{ #category : #classes }
TMEnvironment >> installClass: aClass [
 
	classes at: aClass name put: aClass.

]

{ #category : #mocking }
TMEnvironment >> organization [
	
	^ TMDummyOrganization for: self
]

{ #category : #accessing }
TMEnvironment >> packages [
	
	^ { singlePackage }
]
