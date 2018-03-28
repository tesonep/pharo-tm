Class {
	#name : #FakeClass,
	#superclass : #Object,
	#instVars : [
		'superclass',
		'methodDict',
		'format'
	],
	#category : #'TransactionalModifications-Wrappers'
}

{ #category : #'instance creation' }
FakeClass >> basicNew [
	<primitive: 70 error: ec>

]

{ #category : #'reflective operations' }
FakeClass >> initialize [
	superclass := CannotInterpretHandler.
	methodDict := nil.
	format := Object format.
]
