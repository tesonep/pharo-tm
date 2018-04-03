Class {
	#name : #TMImageEnvironment,
	#superclass : #Object,
	#instVars : [
		'wrappedClasses',
		'wrappedMetaclass'
	],
	#category : #'TransactionalModifications-Core'
}

{ #category : #classes }
TMImageEnvironment >> classNamed: aName [
	
	"^ Smalltalk globals at: aName ifAbsent: [ ^ nil ]."
	
	| realClass wrappedClass |
	wrappedClasses at: aName ifPresent: [ :found | ^ found ].
	realClass := Smalltalk globals at: aName ifAbsent: [ ^ nil ].
	
	wrappedClass := AvInstanceDelegationClassProxy target: realClass handler: (InmutableClassHandler for: self).
	wrappedClasses at: aName put: wrappedClass.
	^ wrappedClass.
]

{ #category : #classes }
TMImageEnvironment >> hasClassNamed: aName [

	^ Smalltalk globals includesKey: aName
]

{ #category : #initialization }
TMImageEnvironment >> initialize [
	wrappedClasses := WeakValueDictionary new.
	wrappedMetaclass := WeakValueDictionary new.
]

{ #category : #classes }
TMImageEnvironment >> metaclassNamed: aName [
	
	| realClass wrappedClass |
	wrappedMetaclass at: aName ifPresent: [ :found | ^ found ].
	realClass := Smalltalk globals at: aName ifAbsent: [ ^ nil ].
	
	wrappedClass := AvInstanceDelegationClassProxy target: realClass class handler: (InmutableClassHandler for: self).
	wrappedMetaclass at: aName put: wrappedClass.
	^ wrappedClass.
]

{ #category : #packages }
TMImageEnvironment >> packageOrganizer [
	^ self class environment packageOrganizer 
]
