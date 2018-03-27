!classDefinition: #I category: #Peano!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #Peano!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 19:57:12'!
* aNumber
	^aNumber.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 19:57:21'!
+ aNumber
	^aNumber next.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 19:57:32'!
- aNumber
	Error signal: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 19:57:49'!
/ aNumber
	aNumber = self
		ifTrue: [^I]
		ifFalse: [^Error signal: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].! !

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:08:01'!
< aNumber
	^aNumber ~= self! !

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 19:58:11'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un n�mero mayor o igual a �l'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 19:58:15'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'No se puede restar a un n�mero con otro mayor o igual a �l'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:16:42'!
greaterThan: aNumber
	^false! !

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 19:58:18'!
multiplyWith: aNumber
	^aNumber.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 19:58:22'!
next
	^II.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 19:58:25'!
previous
	self error: 'El n�mero I no tiene n�mero previo'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 15:01:00'!
substractFrom: aNumber
	^aNumber previous.! !


!classDefinition: #II category: #Peano!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #Peano!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 19:54:56'!
* aNumber
	^aNumber multiplyWith: self.! !

!II class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 19:58:35'!
+ aNumber
	^self previous + aNumber next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 19:55:18'!
- aNumber
	^aNumber substractFrom: self.! !

!II class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:27:39'!
/ aNumber
	| n |
	n := I.

	self < aNumber ifTrue: [
		^Error signal: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor 
	].

	self = aNumber ifTrue: [
		^I
	].

	[n * aNumber < self] whileTrue: [
		n := n+I
	].

	n * aNumber = self ifTrue: [
		^n
	] ifFalse: [
		^Error signal: 'Divisi�n no entera'
	].! !

!II class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:15:28'!
< aNumber
	^ aNumber greaterThan: self.! !

!II class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 19:58:48'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un n�mero mayor o igual a �l'.! !

!II class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:18:04'!
greaterThan: aNumber
	^aNumber previous < self previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 19:59:05'!
multiplyWith: aNumber
	^self + (self * aNumber previous).! !

!II class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 19:59:21'!
next
	next ifNil: [
		next := (self cloneNamed: (self name, 'I')) previous: self.
	].
	^next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 14:55:11'!
previous
	previous ifNil: [
		self previous: I
	].
	^previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 19:59:27'!
previous: aNumber
	previous := aNumber.! !

!II class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:47:13'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!II class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 15:05:09'!
substractFrom: aNumber
	^self previous substractFrom: aNumber previous.
! !

II instVarNamed: 'next' put: III!
II instVarNamed: 'previous' put: I!

!classDefinition: #III category: #Peano!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #Peano!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
* aNumber
	^aNumber multiplyWith: self.! !

!III class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
+ aNumber
	^self previous + aNumber next.! !

!III class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
- aNumber
	^aNumber substractFrom: self.! !

!III class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
/ aNumber
	| n |
	n := I.

	self < aNumber ifTrue: [
		^Error signal: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor 
	].

	self = aNumber ifTrue: [
		^I
	].

	[n * aNumber < self] whileTrue: [
		n := n+I
	].

	n * aNumber = self ifTrue: [
		^n
	] ifFalse: [
		^Error signal: 'Divisi�n no entera'
	].! !

!III class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
< aNumber
	^ aNumber greaterThan: self.! !

!III class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un n�mero mayor o igual a �l'.! !

!III class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
greaterThan: aNumber
	^aNumber previous < self previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
multiplyWith: aNumber
	^self + (self * aNumber previous).! !

!III class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
next
	next ifNil: [
		next := (self cloneNamed: (self name, 'I')) previous: self.
	].
	^next.! !

!III class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
previous
	previous ifNil: [
		self previous: I
	].
	^previous.! !

!III class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
previous: aNumber
	previous := aNumber.! !

!III class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!III class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
substractFrom: aNumber
	^self previous substractFrom: aNumber previous.
! !

III instVarNamed: 'next' put: IIII!
III instVarNamed: 'previous' put: II!

!classDefinition: #IIII category: #Peano!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #Peano!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
* aNumber
	^aNumber multiplyWith: self.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
+ aNumber
	^self previous + aNumber next.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
- aNumber
	^aNumber substractFrom: self.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
/ aNumber
	| n |
	n := I.

	self < aNumber ifTrue: [
		^Error signal: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor 
	].

	self = aNumber ifTrue: [
		^I
	].

	[n * aNumber < self] whileTrue: [
		n := n+I
	].

	n * aNumber = self ifTrue: [
		^n
	] ifFalse: [
		^Error signal: 'Divisi�n no entera'
	].! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
< aNumber
	^ aNumber greaterThan: self.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un n�mero mayor o igual a �l'.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
greaterThan: aNumber
	^aNumber previous < self previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
multiplyWith: aNumber
	^self + (self * aNumber previous).! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
next
	next ifNil: [
		next := (self cloneNamed: (self name, 'I')) previous: self.
	].
	^next.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
previous
	previous ifNil: [
		self previous: I
	].
	^previous.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
previous: aNumber
	previous := aNumber.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
removeAllNext
	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 20:33:44'!
substractFrom: aNumber
	^self previous substractFrom: aNumber previous.
! !

IIII instVarNamed: 'next' put: nil!
IIII instVarNamed: 'previous' put: III!