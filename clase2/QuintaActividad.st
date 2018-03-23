!classDefinition: #I category: #QuintaActividad!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'QuintaActividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #QuintaActividad!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:48:51'!
* otroNumero
	^otroNumero! !

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:06:11'!
+ otroNumero
	^otroNumero next! !

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:40:00'!
- otroNumero
	self error: 'No se puede restar a un número con otro mayor o igual a él'! !

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 20:58:54'!
next
	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:05:30'!
previous
	self error: 'El número I no tiene número previo'! !


!classDefinition: #II category: #QuintaActividad!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'QuintaActividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #QuintaActividad!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:33'!
* otroNumero
	otroNumero = I ifTrue: [
		^self.
	] ifFalse: [
		^self + (self * (otroNumero - I))
	].! !

!II class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:29:11'!
+ otroNumero
	^self previous + otroNumero next! !

!II class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:43:26'!
- otroNumero
	otroNumero = I ifTrue: [
		^self previous
	] ifFalse: [
		^self previous - otroNumero previous
	]! !

!II class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:33:10'!
next
	next ifNil: [
		next := (self cloneNamed: (self name, 'I')) previous: self.
	].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:37:47'!
previous
	| previo |
	previo := previous.
	previo ifNil: [previo := I].
	^previo! !

!II class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:33:33'!
previous: numeroPrevio
	previous := numeroPrevio! !

!II class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:47:13'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

II instVarNamed: 'next' put: III!
II instVarNamed: 'previous' put: nil!

!classDefinition: #III category: #QuintaActividad!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'QuintaActividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #QuintaActividad!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:37'!
* otroNumero
	otroNumero = I ifTrue: [
		^self.
	] ifFalse: [
		^self + (self * (otroNumero - I))
	].! !

!III class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:37'!
+ otroNumero
	^self previous + otroNumero next! !

!III class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:37'!
- otroNumero
	otroNumero = I ifTrue: [
		^self previous
	] ifFalse: [
		^self previous - otroNumero previous
	]! !

!III class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:37'!
next
	next ifNil: [
		next := (self cloneNamed: (self name, 'I')) previous: self.
	].
	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:37'!
previous
	| previo |
	previo := previous.
	previo ifNil: [previo := I].
	^previo! !

!III class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:37'!
previous: numeroPrevio
	previous := numeroPrevio! !

!III class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:37'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

III instVarNamed: 'next' put: IIII!
III instVarNamed: 'previous' put: II!

!classDefinition: #IIII category: #QuintaActividad!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'QuintaActividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #QuintaActividad!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:38'!
* otroNumero
	otroNumero = I ifTrue: [
		^self.
	] ifFalse: [
		^self + (self * (otroNumero - I))
	].! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:38'!
+ otroNumero
	^self previous + otroNumero next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:38'!
- otroNumero
	otroNumero = I ifTrue: [
		^self previous
	] ifFalse: [
		^self previous - otroNumero previous
	]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:38'!
next
	next ifNil: [
		next := (self cloneNamed: (self name, 'I')) previous: self.
	].
	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:38'!
previous
	| previo |
	previo := previous.
	previo ifNil: [previo := I].
	^previo! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:38'!
previous: numeroPrevio
	previous := numeroPrevio! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:38'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

IIII instVarNamed: 'next' put: IIIII!
IIII instVarNamed: 'previous' put: III!

!classDefinition: #IIIII category: #QuintaActividad!
DenotativeObject subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'QuintaActividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: #QuintaActividad!
IIIII class
	instanceVariableNames: 'next previous'!

!IIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
* otroNumero
	otroNumero = I ifTrue: [
		^self.
	] ifFalse: [
		^self + (self * (otroNumero - I))
	].! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
+ otroNumero
	^self previous + otroNumero next! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
- otroNumero
	otroNumero = I ifTrue: [
		^self previous
	] ifFalse: [
		^self previous - otroNumero previous
	]! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
next
	next ifNil: [
		next := (self cloneNamed: (self name, 'I')) previous: self.
	].
	^next! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
previous
	| previo |
	previo := previous.
	previo ifNil: [previo := I].
	^previo! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
previous: numeroPrevio
	previous := numeroPrevio! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

IIIII instVarNamed: 'next' put: IIIIII!
IIIII instVarNamed: 'previous' put: IIII!

!classDefinition: #IIIIII category: #QuintaActividad!
DenotativeObject subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'QuintaActividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: #QuintaActividad!
IIIIII class
	instanceVariableNames: 'next previous'!

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
* otroNumero
	otroNumero = I ifTrue: [
		^self.
	] ifFalse: [
		^self + (self * (otroNumero - I))
	].! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
+ otroNumero
	^self previous + otroNumero next! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
- otroNumero
	otroNumero = I ifTrue: [
		^self previous
	] ifFalse: [
		^self previous - otroNumero previous
	]! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
next
	next ifNil: [
		next := (self cloneNamed: (self name, 'I')) previous: self.
	].
	^next! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
previous
	| previo |
	previo := previous.
	previo ifNil: [previo := I].
	^previo! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
previous: numeroPrevio
	previous := numeroPrevio! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

IIIIII instVarNamed: 'next' put: IIIIIII!
IIIIII instVarNamed: 'previous' put: IIIII!

!classDefinition: #IIIIIII category: #QuintaActividad!
DenotativeObject subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'QuintaActividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIII class' category: #QuintaActividad!
IIIIIII class
	instanceVariableNames: 'next previous'!

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
* otroNumero
	otroNumero = I ifTrue: [
		^self.
	] ifFalse: [
		^self + (self * (otroNumero - I))
	].! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
+ otroNumero
	^self previous + otroNumero next! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
- otroNumero
	otroNumero = I ifTrue: [
		^self previous
	] ifFalse: [
		^self previous - otroNumero previous
	]! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
next
	next ifNil: [
		next := (self cloneNamed: (self name, 'I')) previous: self.
	].
	^next! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
previous
	| previo |
	previo := previous.
	previo ifNil: [previo := I].
	^previo! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
previous: numeroPrevio
	previous := numeroPrevio! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

IIIIIII instVarNamed: 'next' put: IIIIIIII!
IIIIIII instVarNamed: 'previous' put: IIIIII!

!classDefinition: #IIIIIIII category: #QuintaActividad!
DenotativeObject subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'QuintaActividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIII class' category: #QuintaActividad!
IIIIIIII class
	instanceVariableNames: 'next previous'!

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
* otroNumero
	otroNumero = I ifTrue: [
		^self.
	] ifFalse: [
		^self + (self * (otroNumero - I))
	].! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
+ otroNumero
	^self previous + otroNumero next! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
- otroNumero
	otroNumero = I ifTrue: [
		^self previous
	] ifFalse: [
		^self previous - otroNumero previous
	]! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
next
	next ifNil: [
		next := (self cloneNamed: (self name, 'I')) previous: self.
	].
	^next! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
previous
	| previo |
	previo := previous.
	previo ifNil: [previo := I].
	^previo! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
previous: numeroPrevio
	previous := numeroPrevio! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

IIIIIIII instVarNamed: 'next' put: IIIIIIIII!
IIIIIIII instVarNamed: 'previous' put: IIIIIII!

!classDefinition: #IIIIIIIII category: #QuintaActividad!
DenotativeObject subclass: #IIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'QuintaActividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIII class' category: #QuintaActividad!
IIIIIIIII class
	instanceVariableNames: 'next previous'!

!IIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
* otroNumero
	otroNumero = I ifTrue: [
		^self.
	] ifFalse: [
		^self + (self * (otroNumero - I))
	].! !

!IIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
+ otroNumero
	^self previous + otroNumero next! !

!IIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
- otroNumero
	otroNumero = I ifTrue: [
		^self previous
	] ifFalse: [
		^self previous - otroNumero previous
	]! !

!IIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
next
	next ifNil: [
		next := (self cloneNamed: (self name, 'I')) previous: self.
	].
	^next! !

!IIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
previous
	| previo |
	previo := previous.
	previo ifNil: [previo := I].
	^previo! !

!IIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
previous: numeroPrevio
	previous := numeroPrevio! !

!IIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:54:41'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

IIIIIIIII instVarNamed: 'next' put: nil!
IIIIIIIII instVarNamed: 'previous' put: IIIIIIII!