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

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:48:51'!
* otroNumero
	^otroNumero! !

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:06:11'!
+ otroNumero
	^otroNumero next! !

!I class methodsFor: 'as yet unclassified' stamp: 'MC 3/26/2018 20:00:41'!
- otroNumero
	Error signal: self descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'as yet unclassified' stamp: 'MC 3/26/2018 20:32:22'!
/ otroNumero
	otroNumero = self
		ifTrue: [^I]
		ifFalse: [^Error signal: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor]! !

!I class methodsFor: 'as yet unclassified' stamp: 'MC 3/26/2018 21:02:58'!
<= otroNumero
	^true! !

!I class methodsFor: 'as yet unclassified' stamp: 'MC 3/26/2018 20:31:04'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un número mayor o igual a él'! !

!I class methodsFor: 'as yet unclassified' stamp: 'MC 3/26/2018 20:00:31'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'No se puede restar a un número con otro mayor o igual a él'! !

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 20:58:54'!
next
	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 21:05:30'!
previous
	self error: 'El número I no tiene número previo'! !


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

!II class methodsFor: 'as yet unclassified' stamp: 'MC 3/26/2018 21:18:33'!
/ otroNumero
	| n |
	n := I.
	self <= otroNumero ifTrue: [
		self = otroNumero ifTrue: [
			^I
		] ifFalse: [
			^Error signal: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor 
		]
	].
	[n * otroNumero <= self] whileTrue: [
		n := n+I
	].
	
	"restamos uno porque tuvimos que pasarnos"
	(n - I) * otroNumero = self
		ifTrue: [ ^(n - I) ]
		ifFalse: [ Error signal: 'División no entera' ].! !

!II class methodsFor: 'as yet unclassified' stamp: 'MC 3/26/2018 21:12:56'!
<= otroNumero
	"el I no tiene previous, entonces tenemos que chequearlo primero"
	otroNumero = I ifTrue: [
		^false
	] ifFalse: [
		^ self previous <= otroNumero previous
	]! !

!II class methodsFor: 'as yet unclassified' stamp: 'MC 3/26/2018 20:31:40'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un número mayor o igual a él'! !

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

II instVarNamed: 'next' put: nil!
II instVarNamed: 'previous' put: nil!