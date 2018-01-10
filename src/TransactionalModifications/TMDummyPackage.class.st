Class {
	#name : #TMDummyPackage,
	#superclass : #RPackage,
	#instVars : [
		'tmEnvironment'
	],
	#category : #'TransactionalModifications-Core'
}

{ #category : #'protected only for tests' }
TMDummyPackage class >> organizer [
	self halt
]

{ #category : #'class tags' }
TMDummyPackage >> addClassTag: aSymbol [
	"Add the class tag from the receiver, if already added do nothing."

	| tagName newTag |
	"strip package name if needed"
	tagName := self toTagName: aSymbol.

	^ self
		classTagNamed: tagName
		ifAbsent: [ newTag := self basicAddClassTag: tagName ]
]

{ #category : #accessing }
TMDummyPackage >> classes [
	^ super classes

]

{ #category : #accessing }
TMDummyPackage >> definedClasses [
	^ classes collect: [ :aName |  tmEnvironment classNamed: aName ]
]

{ #category : #accessing }
TMDummyPackage >> organizer [
	self halt.
]

{ #category : #'private-register' }
TMDummyPackage >> registerClassName: aClassNameSymbol [
	"Nothing to do"
]

{ #category : #accessing }
TMDummyPackage >> tmEnvironment: aEnvironmnet [ 
	tmEnvironment := aEnvironmnet
]
