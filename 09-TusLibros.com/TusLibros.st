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

!CartTest methodsFor: 'testing' stamp: 'MC 6/6/2018 19:08:05'!
test05_cartCanHoldTheSameItemMultipleTimes
	| catalog cart |
	catalog _ Set
		with: 'a book'.
	cart _ Cart forCatalog: catalog.
	cart add: 'a book' quantity: 3.
	self assert: (cart includes: 'a book').
	self assert: 3 equals: (cart quantityFor: 'a book').! !

!CartTest methodsFor: 'testing' stamp: 'MC 6/6/2018 19:03:20'!
test06_cartCannotHoldLessThanOneOfAnItem
	| catalog cart |
	catalog _ Set
		with: 'a book'.
	cart _ Cart forCatalog: catalog.
	self
		should: [ cart add: 'a book' quantity: 0 ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cart itemQuantityShouldBeOneOrMore.
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'testing' stamp: 'MC 6/6/2018 19:07:42'!
test07_cartReturnsQuantityZeroForItemsNotPresent
	| catalog cart |
	catalog _ Set
		with: 'a book'.
	cart _ Cart forCatalog: catalog.
	self assert: 0 equals: (cart quantityFor: 'a book').! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'items catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'item management' stamp: 'MC 6/4/2018 21:57:53'!
add: anItem
	self add: anItem quantity: 1.! !

!Cart methodsFor: 'item management' stamp: 'MC 6/6/2018 19:03:04'!
add: anItem quantity: quantity
	| currentQuantity |
	(catalog includes: anItem) ifFalse: [
		self error: self class bookNotInCatalogMessage.
	].
	(quantity > 0) ifFalse: [
		self error: self class itemQuantityShouldBeOneOrMore.
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

!Cart methodsFor: 'item inspection' stamp: 'MC 6/6/2018 19:06:55'!
quantityFor: anItem
	^items at: anItem ifAbsent: [0].! !

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

!Cart class methodsFor: 'error handling' stamp: 'MC 6/6/2018 19:02:00'!
itemQuantityShouldBeOneOrMore
	^'Item quantity should be one or more'.! !
