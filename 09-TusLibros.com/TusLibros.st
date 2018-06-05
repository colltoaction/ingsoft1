!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'testing' stamp: 'MC 6/4/2018 21:43:55'!
test01_emptyCartHasNoItems
	| catalog cart |
	catalog _ Set new.
	cart _ Cart forCatalog: catalog.
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'testing' stamp: 'MC 6/4/2018 21:48:05'!
test02_cartCanHoldItemInCatalog
	| catalog cart |
	catalog _ Set with: 'a book'.
	cart _ Cart forCatalog: catalog.
	cart add: 'a book'.
	self assert: (cart includes: 'a book').! !

!CartTest methodsFor: 'testing' stamp: 'MC 6/4/2018 21:47:57'!
test03_cartCannotHoldItemNotInCatalog
	| catalog cart |
	catalog _ Set new.
	cart _ Cart forCatalog: catalog.
	self
		should: [ cart add: 'a book' ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cart bookNotInCatalogMessage.
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'testing' stamp: 'MC 6/4/2018 21:47:49'!
test04_cartCanHoldDifferentItems
	| catalog cart |
	catalog _ Set
		with: 'a book'
		with: 'another book'.
	cart _ Cart forCatalog: catalog.
	cart add: 'a book'.
	cart add: 'another book'.
	self assert: (cart includes: 'a book').
	self assert: (cart includes: 'another book').! !

!CartTest methodsFor: 'testing' stamp: 'MC 6/4/2018 21:51:10'!
test05_cartCanHoldTheSameItemMultipleTimes
	| catalog cart |
	catalog _ Set
		with: 'a book'.
	cart _ Cart forCatalog: catalog.
	cart add: 'a book' quantity: 3.
	self assert: (cart includes: 'a book').
	self assert: (cart quantityFor: 'a book') equals: 3.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'items catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'item management' stamp: 'MC 6/4/2018 21:57:53'!
add: anItem
	self add: anItem quantity: 1.! !

!Cart methodsFor: 'item management' stamp: 'MC 6/4/2018 21:58:13'!
add: anItem quantity: quantity
	| currentQuantity |
	(catalog includes: anItem) ifFalse: [
		self error: self class bookNotInCatalogMessage.
	].
	currentQuantity _ items at: anItem ifAbsent: [0].
	items at: anItem put: currentQuantity + quantity.! !


!Cart methodsFor: 'initialization' stamp: 'MC 6/4/2018 21:56:58'!
initializeFor: aCatalog
	catalog _ aCatalog.
	items _ Dictionary new.! !


!Cart methodsFor: 'item inspection' stamp: 'MC 6/4/2018 22:00:00'!
includes: anItem
	^items includesKey: anItem.! !

!Cart methodsFor: 'item inspection' stamp: 'MC 6/4/2018 21:45:49'!
isEmpty
	^items isEmpty.! !

!Cart methodsFor: 'item inspection' stamp: 'MC 6/4/2018 22:00:40'!
quantityFor: anItem
	^items at: anItem.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'MC 6/4/2018 21:23:27'!
forCatalog: aCatalog 
	^self new initializeFor: aCatalog.! !


!Cart class methodsFor: 'error handling' stamp: 'MC 6/4/2018 21:35:47'!
bookNotInCatalogMessage
	^'El libro no puede agregarse al carrito por no estar en el catálogo'.! !
