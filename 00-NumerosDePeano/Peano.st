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
	^'No se puede dividir por un número mayor o igual a él'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 19:58:15'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'No se puede restar a un número con otro mayor o igual a él'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'MC 3/30/2018 17:15:39'!
greaterThanOrEqual: aNumber
	^self = aNumber.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 19:58:18'!
multiplyWith: aNumber
	^aNumber.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 19:58:22'!
next
	^II.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 19:58:25'!
previous
	self error: 'El número I no tiene número previo'.! !

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

!II class methodsFor: 'as yet unclassified' stamp: 'MC 3/30/2018 16:58:18'!
/ aNumber
	| n |
	n := I.

	self < aNumber ifTrue: [
		^Error signal: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor 
	].

	[n * aNumber < self] whileTrue: [
		n := n+I
	].

	^n! !

!II class methodsFor: 'as yet unclassified' stamp: 'MC 3/30/2018 17:17:46'!
< aNumber
	"Double dispatch para que use la implementación del I si es que aNumber lo es"
	^ aNumber greaterThanOrEqual: self.! !

!II class methodsFor: 'as yet unclassified' stamp: 'JA 3/27/2018 19:58:48'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un número mayor o igual a él'.! !

!II class methodsFor: 'as yet unclassified' stamp: 'MC 3/30/2018 17:24:26'!
greaterThanOrEqual: aNumber
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

II instVarNamed: 'next' put: nil!
II instVarNamed: 'previous' put: I!