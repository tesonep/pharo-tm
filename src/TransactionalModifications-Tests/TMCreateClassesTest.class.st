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
TMCreateClassesTest >> testRedefiningClass [
	
	| aDefinition newClass |
	
	aDefinition := CDClassParser parse: 'Object subclass: #TMTSimpleClass
	instanceVariableNames: ''aSlot otherSlot thirdSlot''
	classVariableNames: ''''
	package: ''AllClasses''
	'.
	
	tmEnvironment defineClass: aDefinition.
	
	self assert: (tmEnvironment hasClassNamed: #TMTSimpleClass).
	self assert: (Smalltalk globals hasClassNamed: #TMTSimpleClass).
	
	newClass := tmEnvironment classNamed: #TMTSimpleClass.
	
	self assert: newClass isNotNil.
	self assert: newClass superclass equals: Object.
	self deny: newClass equals: TMTSimpleClass.
	self assert: newClass slots size equals: 3.	
	self assert: TMTSimpleClass slots size equals: 0.	
	
	self assert: newClass basicCategory equals: #AllClasses.
	self assert: newClass category equals: #AllClasses.
]

{ #category : #tests }
TMCreateClassesTest >> testSimpleClass [
	
	| aDefinition newClass |
	
	aDefinition := CDClassParser parse: 'Object subclass: #ASimpleClass
	instanceVariableNames: ''''
	classVariableNames: ''''
	package: ''AllClasses''
	'.
	
	tmEnvironment defineClass: aDefinition.
	
	self assert: (tmEnvironment hasClassNamed: #ASimpleClass).
	self deny: (Smalltalk globals hasClassNamed: #ASimpleClass).
	
	newClass := tmEnvironment classNamed: #ASimpleClass.
	
	self assert: newClass isNotNil.
	self assert: newClass superclass equals: Object.
	
	self assert: newClass basicCategory equals: #AllClasses.
	self assert: newClass category equals: #AllClasses.
]

{ #category : #tests }
TMCreateClassesTest >> testSimpleClassWithSlots [
	
	| aDefinition newClass |
	
	aDefinition := CDClassParser parse: 'Object subclass: #ASimpleClass
	instanceVariableNames: ''aSlot otherSlot''
	classVariableNames: ''''
	package: ''AllClasses''
	'.
	
	tmEnvironment defineClass: aDefinition.
	
	self assert: (tmEnvironment hasClassNamed: #ASimpleClass).
	self deny: (Smalltalk globals hasClassNamed: #ASimpleClass).
	
	newClass := tmEnvironment classNamed: #ASimpleClass.
	
	self assert: newClass isNotNil.
	self assert: newClass superclass equals: Object.
	self assert: newClass slots size equals: 2.	
	
	self assert: newClass basicCategory equals: #AllClasses.
	self assert: newClass category equals: #AllClasses.
	
]
