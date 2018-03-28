Class {
	#name : #TMPackageOrganizer,
	#superclass : #Object,
	#instVars : [
		'packages',
		'environment'
	],
	#category : #'TransactionalModifications-Packages'
}

{ #category : #'instance creation' }
TMPackageOrganizer class >> for: aTMEnvironment [
	^ self basicNew
		environment: aTMEnvironment;
		initialize;
		yourself
]

{ #category : #adding }
TMPackageOrganizer >> createPackageNamed: aName [
	packages
		add:
			(TMPackage new
				tmEnvironment: environment;
				name: aName;
				yourself)
]

{ #category : #accessing }
TMPackageOrganizer >> environment [
	^ environment
]

{ #category : #accessing }
TMPackageOrganizer >> environment: anObject [
	environment := anObject
]

{ #category : #packages }
TMPackageOrganizer >> extendingPackagesOf: aClass [ 
	^ packages select: [ :each | each extendedClasses includes: aClass ]
]

{ #category : #initialization }
TMPackageOrganizer >> initialize [
	packages := OrderedCollection new
]

{ #category : #packages }
TMPackageOrganizer >> packageNamed: aName ifAbsent: aBlockClosure [ 
	^ packages detect: [ :aPackage | aPackage name = aName ] ifNone: aBlockClosure 
]

{ #category : #accessing }
TMPackageOrganizer >> packageOf: aClass [ 
	^ packages detect: [ :each | each classes includes: aClass ]
]

{ #category : #packages }
TMPackageOrganizer >> packageOfClass: aClass [
	
	packages detect: [ :each | each name = aClass basicCategory ] ifFound: [ :aPackage | ^ aPackage  ].

	self halt: 'What are we doing here!!!'.
]

{ #category : #accessing }
TMPackageOrganizer >> packages [
	^ packages
]
