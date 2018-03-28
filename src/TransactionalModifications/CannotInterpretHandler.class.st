Class {
	#name : #CannotInterpretHandler,
	#superclass : #Object,
	#category : #'TransactionalModifications-Wrappers'
}

{ #category : #'reflective operations' }
CannotInterpretHandler >> cannotInterpret: aMessage [
	aMessage selector logCr.
]
