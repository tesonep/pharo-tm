Class {
	#name : #TMEnvironment,
	#superclass : #Object,
	#instVars : [
		'classes',
		'parent',
		'packageOrganizer'
	],
	#category : #'TransactionalModifications-Core'
}

{ #category : #'classes - accessing' }
TMEnvironment >> allClasses [

	^ classes values
]

{ #category : #accessing }
TMEnvironment >> associationAt: aName ifAbsent: aBlock [

	^ classes associationAt: aName ifAbsent: aBlock
]

{ #category : #'classes - accessing' }
TMEnvironment >> at: aName ifAbsent: aBlock [
	
	(self hasClassNamed: aName) ifFalse: [ ^ aBlock value ].
	^ self classNamed: aName
]

{ #category : #'classes - accessing' }
TMEnvironment >> at: aName put: anObject [

	anObject isBehavior ifTrue: [ ^ self installClass: anObject ].
	
	self assert: 'We should not be here'.
	

]

{ #category : #'classes - defining' }
TMEnvironment >> categorizeClass: aClass [
 	
	(self packageOrganizer packageOfClass: aClass) importClass: aClass

]

{ #category : #'classes - accessing' }
TMEnvironment >> classNamed: aName [
 
	(self hasClassNamed: aName) ifFalse: [ ^ nil ].
	^ classes at: aName ifAbsent: [ parent classNamed: aName ]
]

{ #category : #'classes - compiling' }
TMEnvironment >> compile: sourceCode inClassNamed: aClassName [ 

	^ (self classNamed: aClassName) compile: sourceCode. 
]

{ #category : #'classes - slots' }
TMEnvironment >> createSlots: slotDefinitions [
	
	^ slotDefinitions collect: [ :aDef |
		aDef name asSymbol => (self classNamed: aDef typeName asSymbol)
	].
]

{ #category : #'classes - defining' }
TMEnvironment >> defineClass: aDefinition [

	^ TMClassInstaller
		make: [ :builder | 
			builder
				buildEnvironment: ShGlobalsEnvironment new;
				metaclassClass: (self classNamed: #Metaclass);
				environment: self;
				name: aDefinition className;
				superclassName: aDefinition superclassName;
				slots: (self createSlots: aDefinition slots);
				category: aDefinition packageName ]
]

{ #category : #'classes - accessing' }
TMEnvironment >> definedClassesAt: aName ifAbsent: aBlock [
	^ classes at: aName ifAbsent: aBlock
]

{ #category : #accessing }
TMEnvironment >> description [
	

	^ self asString
]

{ #category : #packages }
TMEnvironment >> ensurePackageNamed: aName [
	^ packageOrganizer
		packageNamed: aName
		ifAbsent: [ packageOrganizer createPackageNamed: aName ]
]

{ #category : #'classes - accessing' }
TMEnvironment >> hasClassNamed: aName [ 

	^ (classes includesKey: aName) or: [ parent hasClassNamed: aName ]
]

{ #category : #'classes - defining' }
TMEnvironment >> importClass: aClass [
	| definition |
	definition := (CDClassParser parse: aClass definition).
	self ensurePackageNamed: definition packageName.
	^ self defineClass: definition
]

{ #category : #packages }
TMEnvironment >> importPackage: aName [ 

	| originalPackage |
	originalPackage := parent packageOrganizer packageNamed: aName.
	
	originalPackage classes do: [ :each | self importClass: each ]
]

{ #category : #initialization }
TMEnvironment >> initialize [
	super initialize.

	classes := Dictionary new.
	parent := TMImageEnvironment new.

	packageOrganizer := TMPackageOrganizer for: self.

]

{ #category : #'classes - defining' }
TMEnvironment >> installClass: aClass [
 
	classes at: aClass name put: aClass.

]

{ #category : #accessing }
TMEnvironment >> organization [
	
	^ TMDummyOrganization for: self
]

{ #category : #packages }
TMEnvironment >> packageOrganizer [
	^ packageOrganizer
]

{ #category : #packages }
TMEnvironment >> packages [
	
	^ packageOrganizer packages
]
