!classDefinition: #Amalia category: #TerceraActividad!
DenotativeObject subclass: #Amalia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerceraActividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Amalia class' category: #TerceraActividad!
Amalia class
	instanceVariableNames: 'energia'!

!Amalia class methodsFor: 'as yet unclassified' stamp: 'JA 3/19/2018 20:27:03'!
comer: gramosDeComida
	energia := energia + 4 * gramosDeComida! !

!Amalia class methodsFor: 'as yet unclassified' stamp: 'JA 3/19/2018 20:23:31'!
energia
	^energia! !

!Amalia class methodsFor: 'as yet unclassified' stamp: 'JA 3/19/2018 20:28:00'!
volar: kilometrosDeDistancia
	energia := energia - kilometrosDeDistancia - 10! !

Amalia instVarNamed: 'energia' put: 110!