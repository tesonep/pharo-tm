Class {
	#name : #TMClassInstaller,
	#superclass : #ShiftAnonymousClassInstaller,
	#category : #'TransactionalModifications-Core'
}

{ #category : #building }
TMClassInstaller >> installInEnvironment: newClass [

	self installingEnvironment installClass: newClass withName: newClass name 
]

{ #category : #building }
TMClassInstaller >> lookupOldClass [
	oldClass ifNil: [ oldClass := self installingEnvironment classNamed: builder name ifAbsent: [ nil ] ]
]

{ #category : #notifications }
TMClassInstaller >> recategorize: newClass to: category [
	
	newClass basicCategory: category.
	self installingEnvironment environment categorizeClass: newClass.
	
]

{ #category : #validating }
TMClassInstaller >> validateReadOnlyInstancesOf: aClass [
	
	aClass ifNil: [ ^ self ].
	
	super validateReadOnlyInstancesOf: aClass
]
