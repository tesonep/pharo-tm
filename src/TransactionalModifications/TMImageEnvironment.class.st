Class {
	#name : #TMImageEnvironment,
	#superclass : #Object,
	#category : #'TransactionalModifications-Core'
}

{ #category : #classes }
TMImageEnvironment >> classNamed: aName [

	^ Smalltalk globals at: aName ifAbsent: [ nil ]
]

{ #category : #classes }
TMImageEnvironment >> hasClassNamed: aName [

	^ Smalltalk globals includesKey: aName
]
