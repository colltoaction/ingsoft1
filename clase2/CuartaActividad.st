!classDefinition: #Amalia category: #CuartaActividad!
DenotativeObject subclass: #Amalia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CuartaActividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Amalia class' category: #CuartaActividad!
Amalia class
	instanceVariableNames: 'energia'!

!Amalia class methodsFor: 'as yet unclassified' stamp: 'JA 3/19/2018 20:27:03'!
comer: gramosDeComida
	energia := energia + 4 * gramosDeComida! !

!Amalia class methodsFor: 'as yet unclassified' stamp: 'JA 3/19/2018 20:23:31'!
energia
	^energia! !

!Amalia class methodsFor: 'as yet unclassified' stamp: 'JA 3/22/2018 20:48:27'!
volar: kilometrosDeDistancia
	| nuevaEnergia |
	nuevaEnergia := energia - kilometrosDeDistancia - 10.
	nuevaEnergia <= 0 ifTrue: [
		"Opción 1: Lanzar error"
		"self error: 'Amalia no se puede quedar sin energía'"
		
		"Opción 2: Borrar el objeto del ambiente"
		self removeFromSystem
	].
	energia := nuevaEnergia! !

Amalia instVarNamed: 'energia' put: 0!