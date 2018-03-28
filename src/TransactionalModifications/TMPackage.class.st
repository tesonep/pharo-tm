Class {
	#name : #TMPackage,
	#superclass : #RPackage,
	#instVars : [
		'tmEnvironment',
		'organizer'
	],
	#category : #'TransactionalModifications-Packages'
}

{ #category : #'protected only for tests' }
TMPackage class >> organizer [
	self halt
]

{ #category : #'class tags' }
TMPackage >> addClassTag: aSymbol [
	"Add the class tag from the receiver, if already added do nothing."

	| tagName newTag |
	"strip package name if needed"
	tagName := self toTagName: aSymbol.

	^ self
		classTagNamed: tagName
		ifAbsent: [ newTag := self basicAddClassTag: tagName ]
]

{ #category : #accessing }
TMPackage >> classes [
	^ super classes

]

{ #category : #accessing }
TMPackage >> definedClasses [
	^ classes collect: [ :aName |  tmEnvironment classNamed: aName ]
]

{ #category : #accessing }
TMPackage >> organizer [
	^ organizer
]

{ #category : #accessing }
TMPackage >> organizer: anOrganizer [
	organizer := anOrganizer 
]

{ #category : #'private-register' }
TMPackage >> registerClassName: aClassNameSymbol [
	"Nothing to do"
]

{ #category : #accessing }
TMPackage >> tmEnvironment: aEnvironmnet [ 
	tmEnvironment := aEnvironmnet
]
