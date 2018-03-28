Class {
	#name : #TMSystemEnvironment,
	#superclass : #Object,
	#instVars : [
		'navigationEnvironment',
		'tmEnvironment'
	],
	#category : #'TransactionalModifications-Calypso'
}

{ #category : #'instance creation' }
TMSystemEnvironment class >> for: aTMEnvironment [

	^ self basicNew
		tmEnvironment: aTMEnvironment;
		initialize;
		yourself
]

{ #category : #transforming }
TMSystemEnvironment >> asGlobalScopeIn: aNavigationEnvironment [ 
	
	navigationEnvironment := aNavigationEnvironment.
	
	^ ClySystemEnvironmentScope of: self in: aNavigationEnvironment named: self description
]

{ #category : #compiling }
TMSystemEnvironment >> compileANewClassFrom: aDefinition notifying: notifier startingFrom: aSelectedClass [ 
	
	^ tmEnvironment defineClass: (CDClassParser parse: aDefinition).

]

{ #category : #packages }
TMSystemEnvironment >> createPackageNamed: aName [ 
	tmEnvironment packageOrganizer createPackageNamed: aName
]

{ #category : #accessing }
TMSystemEnvironment >> description [
	
	^ tmEnvironment description
]

{ #category : #accessing }
TMSystemEnvironment >> navigationEnvironment [
	^ navigationEnvironment
]

{ #category : #accessing }
TMSystemEnvironment >> navigationEnvironment: aNavigationEnvironment [ 
	navigationEnvironment := aNavigationEnvironment
]

{ #category : #'accessing environment' }
TMSystemEnvironment >> packages [
	
	^ tmEnvironment packages
]

{ #category : #'accessing environment' }
TMSystemEnvironment >> packagesDo: aBlock [
	
	self packages do: aBlock
]

{ #category : #events }
TMSystemEnvironment >> subscribe: aNavigationEnvironment [ 
	self shouldBeImplemented.
]

{ #category : #accessing }
TMSystemEnvironment >> tmEnvironment [
	^ tmEnvironment
]

{ #category : #accessing }
TMSystemEnvironment >> tmEnvironment: anObject [
	tmEnvironment := anObject
]

{ #category : #events }
TMSystemEnvironment >> unsubscribe: anObject [
]

{ #category : #events }
TMSystemEnvironment >> when: anAnnouncementClass send: aSelector to: anObject [
	

]
