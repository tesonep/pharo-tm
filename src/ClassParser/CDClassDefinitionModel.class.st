"
| code |
code := Point definitionForNautilus.

TextModel new
	text: code;
	title: 'Test';
	beForCode;
	behavior: Point;
	aboutToStyle: true;
	owner: (CDClassDefinitionModel new code: code);
	openWithSpec
"
Class {
	#name : #CDClassDefinitionModel,
	#superclass : #Object,
	#instVars : [
		'code'
	],
	#category : #ClassParser
}

{ #category : #accessing }
CDClassDefinitionModel >> code: aString [ 
	code := aString
]

{ #category : #compatibility }
CDClassDefinitionModel >> selectedMessage [
	
	^ CDClassParser parse: code
]
