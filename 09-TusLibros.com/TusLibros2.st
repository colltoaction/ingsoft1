!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'testing' stamp: 'JA 6/8/2018 08:43:07'!
test01_emptyCartHasNoItems
	| catalog cart |
	catalog _ Catalog empty.
	cart _ Cart forCatalog: catalog.
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'testing' stamp: 'JA 6/8/2018 08:56:54'!
test02_cartCanHoldItemInCatalog
	| cart |
	cart _ Cart forCatalog: TusLibrosTestResource catalogWithOneItem.
	cart add: 'a book'.
	self assert: (cart includes: 'a book').! !

!CartTest methodsFor: 'testing' stamp: 'JA 6/8/2018 08:47:24'!
test03_cartCannotHoldItemNotInCatalog
	| catalog cart |
	catalog _ Catalog empty.
	cart _ Cart forCatalog: catalog.
	self
		should: [ cart add: 'a book' ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cart bookNotInCatalogMessage.
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'testing' stamp: 'JA 6/8/2018 08:57:27'!
test04_cartCanHoldDifferentItems
	| cart |
	cart _ Cart forCatalog: TusLibrosTestResource catalogWithTwoItems.
	cart add: 'a book'.
	cart add: 'another book'.
	self assert: (cart includes: 'a book').
	self assert: (cart includes: 'another book').! !

!CartTest methodsFor: 'testing' stamp: 'JA 6/8/2018 08:58:04'!
test05_cartCanHoldTheSameItemMultipleTimes
	| cart |
	cart _ Cart forCatalog: TusLibrosTestResource catalogWithOneItem.
	cart add: 'a book' quantity: 3.
	self assert: (cart includes: 'a book').
	self assert: 3 equals: (cart quantityFor: 'a book').! !

!CartTest methodsFor: 'testing' stamp: 'JA 6/8/2018 08:58:17'!
test06_cartCannotHoldLessThanOneOfAnItem
	| cart |
	cart _ Cart forCatalog: TusLibrosTestResource catalogWithOneItem.
	self
		should: [ cart add: 'a book' quantity: 0 ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cart itemQuantityShouldBeOneOrMoreMessage.
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'testing' stamp: 'JA 6/8/2018 08:58:30'!
test07_cartReturnsQuantityZeroForItemsNotPresent
	| cart |
	cart _ Cart forCatalog: TusLibrosTestResource catalogWithOneItem.
	self assert: 0 equals: (cart quantityFor: 'a book').! !

!CartTest methodsFor: 'testing' stamp: 'JA 6/8/2018 08:58:47'!
test08_cartCannotHoldNonIntegerQuantitiesOfAnItem
	| cart |
	cart _ Cart forCatalog: TusLibrosTestResource catalogWithOneItem.
	self
		should: [ cart add: 'a book' quantity: 1.5 ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cart itemQuantityShouldBeAnIntegerMessage.
	self assert: cart isEmpty.! !


!classDefinition: #CheckoutTest category: #TusLibros!
TestCase subclass: #CheckoutTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CheckoutTest methodsFor: 'testing' stamp: 'JA 6/11/2018 17:51:19'!
test01_cannotCheckoutAnEmptyCart
	| catalog cart card cashier market |
	catalog _ Catalog empty.
	market _ TusLibrosTestResource marketWithOneUserForCatalog: catalog.
	
	cart _ market newCartFor: TusLibrosTestResource aUser.
	cashier _ market newCashier.
	card _ CreditCard new.
	
	self
		should: [ cashier checkout: cart withCreditCard: card. ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier cannotCheckoutEmptyCartMessage.! !

!CheckoutTest methodsFor: 'testing' stamp: 'JA 6/11/2018 17:53:26'!
test02_checkoutOfACartWithOneProductTotalPriceIsTheProductsPrice
	| catalog cart card cashier totalPrice market |
	catalog _ TusLibrosTestResource catalogWithOneItem.
	market _ TusLibrosTestResource marketWithOneUserForCatalog: catalog.
	
	cart _ market newCartFor: TusLibrosTestResource aUser.
	cart add: 'a book'.
	cashier _ market newCashier.
	card _ CreditCard withExpirationDate: FixedGregorianDate theEndOfTime.
	
	totalPrice _ cashier checkout: cart withCreditCard: card.
	self assert: totalPrice equals: (catalog priceOf: 'a book').! !

!CheckoutTest methodsFor: 'testing' stamp: 'JA 6/11/2018 17:53:43'!
test03_checkoutOfACartWithMultipleProductsTotalPriceIsTheSumOfTheProductsPrices
	| card cart cashier catalog totalPrice market |
	catalog _ TusLibrosTestResource catalogWithTwoItems.
	market _ TusLibrosTestResource marketWithOneUserForCatalog: catalog.
	
	cart _ market newCartFor: TusLibrosTestResource aUser.
	cart add: 'a book' quantity: 2.
	cart add: 'another book'.
	cashier _ market newCashier.
	card _ CreditCard withExpirationDate: FixedGregorianDate theEndOfTime.
	
	totalPrice _ cashier checkout: cart withCreditCard: card.
	self assert: totalPrice equals: 203 * peso.! !

!CheckoutTest methodsFor: 'testing' stamp: 'JA 6/11/2018 17:53:55'!
test04_cannotBuyWithAnExpiredCreditCard
	| card cart cashier catalog market |
	catalog _ TusLibrosTestResource catalogWithOneItem.
	market _ TusLibrosTestResource marketWithOneUserForCatalog: catalog.
	
	cart _ market newCartFor: TusLibrosTestResource aUser.
	cart add: 'a book'.
	cashier _ market newCashier.
	card _ CreditCard withExpirationDate: FixedGregorianDate yesterday.
	
	self
		should: [ cashier checkout: cart withCreditCard: card. ]
		raise: Error - MessageNotUnderstood
		withMessageText: Cashier cannotCheckoutWithExpiredCreditCardMessage.! !


!classDefinition: #MarketTest category: #TusLibros!
TestCase subclass: #MarketTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MarketTest methodsFor: 'testing' stamp: 'JA 6/7/2018 22:41:53'!
test01_marketCanGiveKnownUserANewCart
	| catalog market users |
	users _ Set with: 'a user'.
	catalog _ Catalog empty.
	market _ Market forUsers: users buyingFromCatalog: catalog.
	self assert: (market newCartFor: 'a user') isEmpty.! !

!MarketTest methodsFor: 'testing' stamp: 'JA 6/8/2018 08:56:18'!
test02_userCanAddItemFromCatalogToMarketsCart
	| market users cart |
	users _ Set with: 'a user'.
	market _ Market forUsers: users buyingFromCatalog: TusLibrosTestResource catalogWithOneItem.
	cart _ market newCartFor: 'a user'.
	cart add: 'a book'.
	self assert: (cart includes: 'a book').! !

!MarketTest methodsFor: 'testing' stamp: 'JA 6/7/2018 22:42:57'!
test03_marketCannotGiveUnknownUserANewCart
	| catalog market users |
	users _ Set new.
	catalog _ Catalog empty.
	market _ Market forUsers: users buyingFromCatalog: catalog.
	self
		should: [ market newCartFor: 'a user' ]
		raise: Error - MessageNotUnderstood
		withMessageText: Market userNotKnown.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'items catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'item management' stamp: 'MC 6/4/2018 21:57:53'!
add: anItem
	self add: anItem quantity: 1.! !

!Cart methodsFor: 'item management' stamp: 'JA 6/7/2018 22:38:05'!
add: anItem quantity: quantity
	(catalog includes: anItem) ifFalse: [
		self error: self class bookNotInCatalogMessage.
	].
	(quantity > 0) ifFalse: [
		self error: self class itemQuantityShouldBeOneOrMoreMessage.
	].
	(quantity isInteger) ifFalse: [
		self error: self class itemQuantityShouldBeAnIntegerMessage.
	].
	items add: anItem withOccurrences: quantity.! !


!Cart methodsFor: 'initialization' stamp: 'JA 6/7/2018 20:21:57'!
initializeFor: aCatalog
	catalog _ aCatalog.
	items _ Bag new.! !


!Cart methodsFor: 'item inspection' stamp: 'JA 6/7/2018 20:26:26'!
includes: anItem
	^items includes: anItem.! !

!Cart methodsFor: 'item inspection' stamp: 'MC 6/4/2018 21:45:49'!
isEmpty
	^items isEmpty.! !

!Cart methodsFor: 'item inspection' stamp: 'JA 6/7/2018 22:23:15'!
itemsList
	^items asSet.! !

!Cart methodsFor: 'item inspection' stamp: 'JA 6/7/2018 20:27:20'!
quantityFor: anItem
	^items occurrencesOf: anItem.! !

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

!Cart class methodsFor: 'error handling' stamp: 'JA 6/7/2018 22:39:43'!
itemQuantityShouldBeAnIntegerMessage
	^'La cantidad del item debe ser un número entero'.! !

!Cart class methodsFor: 'error handling' stamp: 'JA 6/7/2018 22:39:32'!
itemQuantityShouldBeOneOrMoreMessage
	^'La cantidad del item debe ser mayor o igual a 1'.! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'JA 6/7/2018 23:20:40'!
checkout: aCart withCreditCard: aCreditCard 
	(aCart isEmpty) ifTrue: [
		self error: self class cannotCheckoutEmptyCartMessage.
	].

	(aCreditCard expired) ifTrue: [
		self error: self class cannotCheckoutWithExpiredCreditCardMessage.
	].

	^aCart itemsList inject: 0 into: [ :totalPrice :item | totalPrice + ((catalog priceOf: item) * (aCart quantityFor: item)) ].! !


!Cashier methodsFor: 'initializing' stamp: 'JA 6/7/2018 22:45:11'!
initializeFor: aCatalog
	catalog _ aCatalog.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error handling' stamp: 'JA 6/7/2018 23:16:08'!
cannotCheckoutEmptyCartMessage
	^'No se puede comprar con un carrito vacío.'! !

!Cashier class methodsFor: 'error handling' stamp: 'JA 6/7/2018 23:20:26'!
cannotCheckoutWithExpiredCreditCardMessage
	^'No se puede comprar con una tarjeta de crédito vencida.'! !


!Cashier class methodsFor: 'instance creation' stamp: 'JA 6/7/2018 22:44:51'!
forCatalog: aCatalog 
	^self new initializeFor: aCatalog.! !


!classDefinition: #Catalog category: #TusLibros!
Object subclass: #Catalog
	instanceVariableNames: 'priceOfItem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Catalog methodsFor: 'initializing' stamp: 'JA 6/7/2018 22:35:45'!
add: item withPrice: price
	priceOfItem at: item put: price.! !

!Catalog methodsFor: 'initializing' stamp: 'JA 6/7/2018 22:41:38'!
includes: item
	^priceOfItem includesKey: item.! !

!Catalog methodsFor: 'initializing' stamp: 'JA 6/7/2018 22:34:57'!
initialize
	priceOfItem _ Dictionary new.! !

!Catalog methodsFor: 'initializing' stamp: 'JA 6/7/2018 22:37:02'!
priceOf: item
	(priceOfItem includesKey: item) ifFalse: [
		self error: self class.
	].
	^priceOfItem at: item.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Catalog class' category: #TusLibros!
Catalog class
	instanceVariableNames: ''!

!Catalog class methodsFor: 'instance creation' stamp: 'JA 6/7/2018 22:34:16'!
empty
	^self new.! !


!Catalog class methodsFor: 'error handling' stamp: 'JA 6/7/2018 22:40:32'!
itemNotInCatalogHasNoPriceMessage
	^'No se puede obtener el precio de un ítem que no se encuentra en el catálogo'.! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initializing' stamp: 'JA 6/7/2018 23:18:39'!
initializeWith: anExpirationDate
	expirationDate _ anExpirationDate.! !


!CreditCard methodsFor: 'inspecting' stamp: 'JA 6/7/2018 23:24:22'!
expired
	^expirationDate < FixedGregorianDate today.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'JA 6/7/2018 23:17:31'!
withExpirationDate: expirationDate
	^self new initializeWith: expirationDate! !


!classDefinition: #Market category: #TusLibros!
Object subclass: #Market
	instanceVariableNames: 'catalog users'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Market methodsFor: 'initialization' stamp: 'JA 6/7/2018 22:26:47'!
withUsers: knownUsers andCatalog: aCatalog
	users _ knownUsers.
	catalog _ aCatalog.! !


!Market methodsFor: 'cart management' stamp: 'MC 6/6/2018 19:30:54'!
newCartFor: user
	(users includes: user) ifFalse: [
		self error: self class userNotKnown.
	].
	^Cart forCatalog: catalog.! !


!Market methodsFor: 'cashier' stamp: 'JA 6/11/2018 17:45:40'!
newCashier
	^Cashier forCatalog: catalog.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Market class' category: #TusLibros!
Market class
	instanceVariableNames: ''!

!Market class methodsFor: 'instance creation' stamp: 'JA 6/7/2018 22:27:15'!
forUsers: users buyingFromCatalog: catalog
	^self new withUsers: users andCatalog: catalog! !


!Market class methodsFor: 'error handling' stamp: 'MC 6/6/2018 19:30:03'!
userNotKnown
	^'No puede darse un carrito a un usuario desconocido'.! !


!classDefinition: #TusLibrosTestResource category: #TusLibros!
Object subclass: #TusLibrosTestResource
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosTestResource class' category: #TusLibros!
TusLibrosTestResource class
	instanceVariableNames: ''!

!TusLibrosTestResource class methodsFor: 'catalog' stamp: 'JA 6/11/2018 17:28:32'!
catalogWithOneItem
	^Catalog empty add: 'a book' withPrice: 100 * peso.! !

!TusLibrosTestResource class methodsFor: 'catalog' stamp: 'JA 6/11/2018 17:28:25'!
catalogWithTwoItems
	^self catalogWithOneItem add: 'another book' withPrice: 3 * peso.! !


!TusLibrosTestResource class methodsFor: 'users' stamp: 'JA 6/11/2018 17:44:52'!
aUser
	^'a user'.! !


!TusLibrosTestResource class methodsFor: 'market' stamp: 'JA 6/11/2018 17:52:32'!
marketWithOneUserForCatalog: aCatalog
	| users |
	users _ Set with: TusLibrosTestResource aUser.
	^Market forUsers: users buyingFromCatalog: aCatalog.
	! !
