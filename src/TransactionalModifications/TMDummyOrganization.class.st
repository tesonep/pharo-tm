Class {
	#name : #TMDummyOrganization,
	#superclass : #Object,
	#instVars : [
		'tmEnvironment'
	],
	#category : #'TransactionalModifications-Core'
}

{ #category : #'instance creation' }
TMDummyOrganization class >> for: aTMEnvironment [
	^ self new
		tmEnvironment: aTMEnvironment;
		yourself
]

{ #category : #mocking }
TMDummyOrganization >> categoryOfElement: aString [ 
	self shouldBeImplemented.
]

{ #category : #mocking }
TMDummyOrganization >> listAtCategoryNamed: aCategory [
 	
	^ tmEnvironment allClasses select: [ :e | e basicCategory = aCategory ] thenCollect: #name
]

{ #category : #accessing }
TMDummyOrganization >> tmEnvironment [
	^ tmEnvironment
]

{ #category : #accessing }
TMDummyOrganization >> tmEnvironment: anObject [
	tmEnvironment := anObject
]
