Class {
	#name : #TMSystemEnvironment,
	#superclass : #Object,
	#instVars : [
		'navigationEnvironment',
		'tmEnvironment',
		'subscribers'
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

	| def oldClassDef newClass |

	self halt.
	def := (CDClassParser parse: aDefinition).

	oldClassDef := (tmEnvironment classNamed: def className) ifNotNil: #definition.
	newClass := tmEnvironment defineClass: def.

	self notifyClassModificationFrom: oldClassDef to: newClass.
	
	^ newClass
]

{ #category : #accessing }
TMSystemEnvironment >> description [
	
	^ tmEnvironment description
]

{ #category : #initialization }
TMSystemEnvironment >> initialize [
	super initialize.
	subscribers := OrderedCollection new.
]

{ #category : #accessing }
TMSystemEnvironment >> navigationEnvironment [
	^ navigationEnvironment
]

{ #category : #accessing }
TMSystemEnvironment >> navigationEnvironment: aNavigationEnvironment [ 
	navigationEnvironment := aNavigationEnvironment
]

{ #category : #events }
TMSystemEnvironment >> notifyClassModificationFrom: oldDefinition to: newClass [
	| ann |
	ann := oldDefinition
		ifNil: [ ClassAdded class: newClass category: newClass category ]
		ifNotNil: [ ClassModifiedClassDefinition classDefinitionChangedFrom: oldDefinition to: newClass definition ].

	subscribers do: [ :e | e handleSystemChange: ann ]
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
	subscribers add: aNavigationEnvironment.
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
