Class {
	#name : #TMCreateClassesTest,
	#superclass : #TestCase,
	#instVars : [
		'tmEnvironment'
	],
	#category : #'TransactionalModifications-Tests'
}

{ #category : #running }
TMCreateClassesTest >> setUp [
	
	super setUp.
	tmEnvironment := TMEnvironment new.
]

{ #category : #tests }
TMCreateClassesTest >> testCompilingExistingClassProducesAnError [
	
	| newClass |

	self assert: (tmEnvironment hasClassNamed: #TMTSimpleClass).
	newClass := tmEnvironment classNamed: #TMTSimpleClass.
	self should: [newClass compile: 'aMethod ^ 42'] raise: Error.
	

]

{ #category : #tests }
TMCreateClassesTest >> testImportingPackage [
	
	| oldClass newClass objectInEnv |

	tmEnvironment importPackage: 'TransactionalModifications-Test-Classes'.		
	self assert: (tmEnvironment hasClassNamed: #TMTSimpleClass).
	self assert: (Smalltalk globals hasClassNamed: #TMTSimpleClass).
	
	newClass := tmEnvironment classNamed: #TMTSimpleClass.
	oldClass := Smalltalk globals classNamed: #TMTSimpleClass.
	objectInEnv := tmEnvironment classNamed: #Object.
	
	self assert: newClass isNotNil.
	self assert: newClass superclass equals: objectInEnv.
	
	self assert: newClass basicCategory equals: #'TransactionalModifications-Test-Classes'.
	self assert: newClass category equals: #'TransactionalModifications-Test-Classes'.

	self assert: oldClass basicCategory equals: #'TransactionalModifications-Test-Classes'.
	self assert: oldClass category equals: #'TransactionalModifications-Test-Classes'.
	
	self assert: newClass package class equals: TMPackage.
	self assert: oldClass package class equals: RPackage
]

{ #category : #tests }
TMCreateClassesTest >> testRedefiningClass [
	
	| aDefinition newClass objectInEnv |
	
	aDefinition := CDClassParser parse: 'Object subclass: #TMTSimpleClass
	instanceVariableNames: ''aSlot otherSlot thirdSlot''
	classVariableNames: ''''
	package: ''TransactionalModifications-Test-Classes''
	'.
	
	tmEnvironment packageOrganizer createPackageNamed: 'TransactionalModifications-Test-Classes'.
	tmEnvironment defineClass: aDefinition.
	
	self assert: (tmEnvironment hasClassNamed: #TMTSimpleClass).
	self assert: (Smalltalk globals hasClassNamed: #TMTSimpleClass).
	
	newClass := tmEnvironment classNamed: #TMTSimpleClass.
	objectInEnv := tmEnvironment classNamed: #Object.
	
	self assert: newClass isNotNil.
	self assert: newClass superclass equals: objectInEnv.

	self deny: newClass equals: TMTSimpleClass.
	self assert: newClass slots size equals: 3.	
	self assert: TMTSimpleClass slots size equals: 0.	
	
	self assert: newClass basicCategory equals: #'TransactionalModifications-Test-Classes'.
	self assert: newClass category equals: #'TransactionalModifications-Test-Classes'.
]

{ #category : #tests }
TMCreateClassesTest >> testSimpleClass [
	
	| aDefinition newClass |
		
	aDefinition := CDClassParser parse: 'Object subclass: #ASimpleClass
	instanceVariableNames: ''''
	classVariableNames: ''''
	package: ''TransactionalModifications-Test-Classes''
	'.
	
	tmEnvironment packageOrganizer createPackageNamed: 'TransactionalModifications-Test-Classes'.	
	tmEnvironment defineClass: aDefinition.
	
	self assert: (tmEnvironment hasClassNamed: #ASimpleClass).
	self deny: (Smalltalk globals hasClassNamed: #ASimpleClass).
	
	newClass := tmEnvironment classNamed: #ASimpleClass.
	
	self assert: newClass isNotNil.
	self assert: newClass superclass name equals: #Object.
		
	self assert: newClass basicCategory equals: #'TransactionalModifications-Test-Classes'.
	self assert: newClass category equals: #'TransactionalModifications-Test-Classes'.
	
]

{ #category : #tests }
TMCreateClassesTest >> testSimpleClassCreatingInstance [
	
	| aDefinition newClass |
		
	aDefinition := CDClassParser parse: 'Object subclass: #ASimpleClass
	instanceVariableNames: ''''
	classVariableNames: ''''
	package: ''TransactionalModifications-Test-Classes''
	'.
	
	tmEnvironment packageOrganizer createPackageNamed: 'TransactionalModifications-Test-Classes'.	
	tmEnvironment defineClass: aDefinition.
	
	newClass := tmEnvironment classNamed: #ASimpleClass.
	newClass new.
]

{ #category : #tests }
TMCreateClassesTest >> testSimpleClassWithSlots [
	
	| aDefinition newClass objectInEnvironment |
		
	aDefinition := CDClassParser parse: 'Object subclass: #ASimpleClass
	instanceVariableNames: ''aSlot otherSlot''
	classVariableNames: ''''
	package: ''TransactionalModifications-Test-Classes''
	'.

	tmEnvironment packageOrganizer createPackageNamed: 'TransactionalModifications-Test-Classes'.

	tmEnvironment defineClass: aDefinition.
	
	self assert: (tmEnvironment hasClassNamed: #ASimpleClass).
	self deny: (Smalltalk globals hasClassNamed: #ASimpleClass).
	
	newClass := tmEnvironment classNamed: #ASimpleClass.
	objectInEnvironment := tmEnvironment classNamed: #Object.
	
	self assert: newClass isNotNil.
	self assert: newClass superclass equals: objectInEnvironment.
	self assert: newClass class superclass equals: objectInEnvironment class.

	self assert: newClass slots size equals: 2.	
	
	self assert: newClass basicCategory equals: #'TransactionalModifications-Test-Classes'.
	self assert: newClass category equals: #'TransactionalModifications-Test-Classes'.
	
]
