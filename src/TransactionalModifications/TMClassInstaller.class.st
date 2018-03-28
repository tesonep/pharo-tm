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
	oldClass
		ifNil: [ oldClass := self installingEnvironment environment definedClassesAt: builder name ifAbsent: [ nil ] ]
]

{ #category : #notifications }
TMClassInstaller >> recategorize: newClass to: category [
	
	newClass basicCategory: category.
	self installingEnvironment environment categorizeClass: newClass.
	
]
