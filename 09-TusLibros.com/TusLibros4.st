!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'JA 6/12/2018 08:17:18'!
test09CanNotAddNonIntegerNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 1.5 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitFromBlock stolenCreditCardBlock sufficientFundsOnCreditCardBlock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'testing' stamp: 'JA 6/12/2018 19:47:24'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitFromBlock := [ :p1 :p2 | ].
	stolenCreditCardBlock := [ :p1 | false ].
	sufficientFundsOnCreditCardBlock := [ :p1 :p2 | true ].! !

!CashierTest methodsFor: 'testing' stamp: 'MC 6/11/2018 21:00:14'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			on: testObjectsFactory today
			registeringOn:  salesBook
			debitingOn: self ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'testing' stamp: 'JA 6/12/2018 19:33:20'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart
		charging: testObjectsFactory notExpiredCreditCard
		on: testObjectsFactory today
		registeringOn: OrderedCollection new
		debitingOn: self.
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'testing' stamp: 'JA 6/12/2018 19:47:05'!
test03CanNotCheckoutWithAnExpiredCreditCard

	| cart salesBook merchantCalledToDebit |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	merchantCalledToDebit := false.
	debitFromBlock := [ :cardToDebitFrom :totalToDebit | merchantCalledToDebit := true ].
	
	self
		should: [ Cashier 
			toCheckout: cart 
			charging: testObjectsFactory expiredCreditCard 
			on: testObjectsFactory today
			registeringOn: salesBook
			debitingOn: self ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
		].

	self assert: salesBook isEmpty.
	self assert: merchantCalledToDebit not.! !

!CashierTest methodsFor: 'testing' stamp: 'JA 6/12/2018 19:46:45'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier := Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		on: testObjectsFactory today
		registeringOn: salesBook
		debitingOn: self.
	total := cashier checkOut.
					
	self assert: salesBook notEmpty.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'testing' stamp: 'JA 6/12/2018 19:33:55'!
test05CheckoutSendsTransactionToMerchantProcessor

	| cart cashier salesBook cardDebitedFrom total totalDebited card |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	card := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
	debitFromBlock := [ :cardToDebitFrom :totalToDebit |
		cardDebitedFrom := cardToDebitFrom.
		totalDebited := totalToDebit.
	].
 
	cashier := Cashier 
		toCheckout: cart 
		charging: card
		on: testObjectsFactory today
		registeringOn: salesBook
		debitingOn: self.
	total := cashier checkOut.

	self assert: total equals: totalDebited.
	self assert: card equals: cardDebitedFrom.! !

!CashierTest methodsFor: 'testing' stamp: 'JA 6/12/2018 19:35:42'!
test06CanNotCheckoutWithAStolenCreditCard

	| cart salesBook card merchantCalledToDebit |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	card := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
	merchantCalledToDebit := false.
	debitFromBlock := [ :cardToDebitFrom :totalToDebit | merchantCalledToDebit := true ].
	stolenCreditCardBlock := [ :creditCard | true ].
 
	self
		should: [ Cashier 
			toCheckout: cart 
			charging: card
			on: testObjectsFactory today
			registeringOn: salesBook
			debitingOn: self ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: anError messageText = Cashier canNotChargeAStolenCreditCardErrorMessage ].
	
	self assert: salesBook isEmpty.
	self assert: merchantCalledToDebit not.! !

!CashierTest methodsFor: 'testing' stamp: 'JA 6/12/2018 19:47:40'!
test07CanNotCheckoutIfCreditCardDoesNotHaveEnoughFunds

	| cart salesBook card merchantCalledToDebit cashier |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	card := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
	merchantCalledToDebit := false.
	debitFromBlock := [ :cardToDebitFrom :totalToDebit | merchantCalledToDebit := true ].
	sufficientFundsOnCreditCardBlock := [ :funds :creditCard | false ].

	cashier := Cashier 
		toCheckout: cart 
		charging: card
		on: testObjectsFactory today
		registeringOn: salesBook
		debitingOn: self.

	self
		should: [ cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: anError messageText = Cashier canNotChargeACreditCardWithInsufficientFundsMessage ].
	
	self assert: salesBook isEmpty.
	self assert: merchantCalledToDebit not.! !


!CashierTest methodsFor: 'simulating' stamp: 'MC 6/11/2018 20:58:59'!
debitFrom: aCreditCard amount: anAmount
	debitFromBlock value: aCreditCard value: anAmount.! !

!CashierTest methodsFor: 'simulating' stamp: 'JA 6/12/2018 19:32:17'!
isStolen: aCreditCard
	^stolenCreditCardBlock value: aCreditCard.! !

!CashierTest methodsFor: 'simulating' stamp: 'JA 6/12/2018 19:44:58'!
sufficientFunds: funds on: creditCard
	^sufficientFundsOnCreditCardBlock value: funds value: creditCard.! !


!classDefinition: #RestApiTest category: #TusLibros!
TestCase subclass: #RestApiTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestApiTest methodsFor: 'setup' stamp: 'MC 6/16/2018 14:01:42'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!RestApiTest methodsFor: 'testing-create cart' stamp: 'MC 6/16/2018 15:31:17'!
test01CreateCartWithValidClientIdAndPassword
	| api cartId cartsStore |
	cartsStore _ CartsStore new.
	api _ RestApi
		forCatalog: testObjectsFactory defaultCatalog
		andClients: testObjectsFactory defaultClients
		storingOn: cartsStore.
	cartId _ api
		createCartFor: testObjectsFactory activeClient
		with: testObjectsFactory activeClientPassword
		on: testObjectsFactory now.
	self assert: (cartsStore includesKey: cartId).! !

!RestApiTest methodsFor: 'testing-create cart' stamp: 'MC 6/16/2018 15:31:48'!
test02CannotCreateCartWithValidClientIdAndInvalidPassword
	| api cartsStore |
	cartsStore _ CartsStore new.
	api _ RestApi
		forCatalog: testObjectsFactory defaultCatalog
		andClients: testObjectsFactory defaultClients
		storingOn: cartsStore.
	self
		should: [
			api
				createCartFor: testObjectsFactory activeClient
				with: 'invalid password'
				on: testObjectsFactory now ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = RestApi invalidClientIdOrPasswordMessage.
			self assert: cartsStore isEmpty ].! !

!RestApiTest methodsFor: 'testing-create cart' stamp: 'MC 6/16/2018 15:32:32'!
test03CannotCreateCartWithInvalidClientId
	| api cartsStore |
	cartsStore _ CartsStore new.
	api _ RestApi
		forCatalog: testObjectsFactory defaultCatalog
		andClients: testObjectsFactory defaultClients
		storingOn: cartsStore.
	self
		should: [
			api
				createCartFor: 'invalid client id'
				with: testObjectsFactory activeClientPassword
				on: testObjectsFactory now ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = RestApi invalidClientIdOrPasswordMessage.
			self assert: cartsStore isEmpty ].! !


!RestApiTest methodsFor: 'testing-add to cart' stamp: 'MC 6/16/2018 15:33:21'!
test04AddToCartWithValidParameters
	| api cartsStore cart |
	cart _ testObjectsFactory createCart.
	cartsStore _ CartsStore new
		at: 'cart id' put: cart on: testObjectsFactory now;
		yourself.
	api _ RestApi
		forCatalog: testObjectsFactory defaultCatalog
		andClients: testObjectsFactory defaultClients
		storingOn: cartsStore.
	api
		addToCart: 'cart id'
		bookIsbn: testObjectsFactory itemSellByTheStore
		quantity: 2
		on: testObjectsFactory now.
	self assert: 2 equals: (cart occurrencesOf: testObjectsFactory itemSellByTheStore).	! !

!RestApiTest methodsFor: 'testing-add to cart' stamp: 'MC 6/16/2018 15:48:51'!
test05CannotAddToCartWithInvalidCartId
	| api cartsStore cart |
	cart _ testObjectsFactory createCart.
	cartsStore _ CartsStore new
		at: 'cart id' put: cart on: testObjectsFactory now;
		yourself.
	api _ RestApi
		forCatalog: testObjectsFactory defaultCatalog
		andClients: testObjectsFactory defaultClients
		storingOn: cartsStore.
	self
		should: [
			api
				addToCart: 'invalid cart id'
				bookIsbn: testObjectsFactory itemSellByTheStore
				quantity: 2
				on: testObjectsFactory now ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CartsStore invalidCartIdMessage.
			self assert: cart isEmpty ].! !

!RestApiTest methodsFor: 'testing-add to cart' stamp: 'MC 6/16/2018 15:36:42'!
test06CannotAddToCartInvalidIsbn
	| api cartsStore cart |
	cart _ testObjectsFactory createCart.
	cartsStore _ CartsStore new
		at: 'cart id' put: cart on: testObjectsFactory now;
		yourself.
	api _ RestApi
		forCatalog: testObjectsFactory defaultCatalog
		andClients: testObjectsFactory defaultClients
		storingOn: cartsStore.
	self
		should: [
			api
				addToCart: 'cart id'
				bookIsbn: 'invalid isbn'
				quantity: 2
				on: testObjectsFactory now ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ].! !

!RestApiTest methodsFor: 'testing-add to cart' stamp: 'MC 6/16/2018 15:36:59'!
test07CannotAddToCartInvalidQuantity
	| api cartsStore cart |
	cart _ testObjectsFactory createCart.
	cartsStore _ CartsStore new
		at: 'cart id' put: cart on: testObjectsFactory now;
		yourself.
	api _ RestApi
		forCatalog: testObjectsFactory defaultCatalog
		andClients: testObjectsFactory defaultClients
		storingOn: cartsStore.
	self
		should: [
			api
				addToCart: 'cart id'
				bookIsbn: testObjectsFactory itemSellByTheStore
				quantity: -42
				on: testObjectsFactory now ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ].! !

!RestApiTest methodsFor: 'testing-add to cart' stamp: 'MC 6/16/2018 15:42:59'!
test08CannotAddToCartAfter30Minutes
	| api cartsStore cart |
	cart _ testObjectsFactory createCart.
	cartsStore _ CartsStore new
		at: 'cart id' put: cart on: testObjectsFactory now;
		yourself.
	api _ RestApi
		forCatalog: testObjectsFactory defaultCatalog
		andClients: testObjectsFactory defaultClients
		storingOn: cartsStore.
	self
		should: [
			api
				addToCart: 'cart id'
				bookIsbn: testObjectsFactory itemSellByTheStore
				quantity: 7
				on: testObjectsFactory now + 31 minutes ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CartsStore cartIdIsExpired.
			self assert: cart isEmpty ].! !


!RestApiTest methodsFor: 'testing-list cart' stamp: 'JA 6/17/2018 17:27:36'!
test09ListCartReturnsCartItemsCorrectly
	| api cartsStore cart itemList |
	cart _ testObjectsFactory createCart.
	cart add: 1 of: testObjectsFactory itemSellByTheStore.
	cart add: 2 of: testObjectsFactory anotherItemSellByTheStore.
	cartsStore _ CartsStore new
		at: 'cart id' put: cart on: testObjectsFactory now;
		yourself.
	api _ RestApi
		forCatalog: testObjectsFactory defaultCatalog
		andClients: testObjectsFactory defaultClients
		storingOn: cartsStore.
		
	itemList _ api
		listCart: 'cart id'
		on: testObjectsFactory now.
		
	self assert: 2 equals: itemList keys size.
	self assert: (itemList at: testObjectsFactory itemSellByTheStore) equals: 1.
	self assert: (itemList at: testObjectsFactory anotherItemSellByTheStore) equals: 2.! !

!RestApiTest methodsFor: 'testing-list cart' stamp: 'JA 6/17/2018 18:21:38'!
test10CannotListInvalidIdCart
	| api cartsStore cart |
	cart _ testObjectsFactory createCart.
	cart add: 1 of: testObjectsFactory itemSellByTheStore.
	cart add: 2 of: testObjectsFactory anotherItemSellByTheStore.
	cartsStore _ CartsStore new
		at: 'cart id' put: cart on: testObjectsFactory now;
		yourself.
	api _ RestApi
		forCatalog: testObjectsFactory defaultCatalog
		andClients: testObjectsFactory defaultClients
		storingOn: cartsStore.
		
	self should: [
		api
			listCart: 'invalid cart id'
			on: testObjectsFactory now ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CartsStore invalidCartIdMessage ].! !


!RestApiTest methodsFor: 'testing-checkout cart' stamp: 'JA 6/17/2018 18:49:02'!
test11SuccessfulCartCheckoutReturnsTransactionId
	| api cartsStore cart transactionId creditCard |
	cart _ testObjectsFactory createCart.
	cart add: 1 of: testObjectsFactory itemSellByTheStore.
	cartsStore _ CartsStore new
		at: 'cart id' put: cart on: testObjectsFactory now;
		yourself.
	api _ RestApi
		forCatalog: testObjectsFactory defaultCatalog
		andClients: testObjectsFactory defaultClients
		storingOn: cartsStore.
	creditCard _ testObjectsFactory notExpiredCreditCard.
	
	transactionId _ api
		checkoutCart: 'cart id'
		creditCardNumber: creditCard number
		creditCardExpiration: creditCard expiration asString
		creditCardOwner: creditCard owner
		on: testObjectsFactory now.
		
	self assert: transactionId > 0.! !

!RestApiTest methodsFor: 'testing-checkout cart' stamp: 'JA 6/17/2018 18:52:47'!
test12CannotCheckoutWithInvalidCartId
	| api cartsStore cart creditCard |
	cart _ testObjectsFactory createCart.
	cart add: 1 of: testObjectsFactory itemSellByTheStore.
	cartsStore _ CartsStore new
		at: 'cart id' put: cart on: testObjectsFactory now;
		yourself.
	api _ RestApi
		forCatalog: testObjectsFactory defaultCatalog
		andClients: testObjectsFactory defaultClients
		storingOn: cartsStore.
	creditCard _ testObjectsFactory notExpiredCreditCard.
	
	self should: [
		api
			checkoutCart: 'invalid cart id'
			creditCardNumber: creditCard number
			creditCardExpiration: creditCard expiration asString
			creditCardOwner: creditCard owner
			on: testObjectsFactory now ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CartsStore invalidCartIdMessage ].! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'JA 6/12/2018 08:15:48'!
assertIsValidQuantity: aQuantity

	(aQuantity strictlyPositive and: [ aQuantity isInteger ]) ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'JA 6/12/2018 08:12:50'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 18:04'!
catalog
	
	^ catalog! !

!Cart methodsFor: 'queries' stamp: 'JA 6/17/2018 18:11:24'!
items
	^items.! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'enumerating' stamp: 'HernanWilkinson 6/17/2013 18:05'!
itemsDo: aBlock
	
	^items do: aBlock ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'JA 6/12/2018 08:13:52'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartsStore category: #TusLibros!
Object subclass: #CartsStore
	instanceVariableNames: 'carts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartsStore methodsFor: 'accessing' stamp: 'MC 6/16/2018 15:48:05'!
at: cartId on: currentTime
	| lastUsageTime |
	(carts includesKey: cartId) ifFalse: [
		self error: self class invalidCartIdMessage
	].
	lastUsageTime _ (carts at: cartId) key.
	currentTime > (lastUsageTime + 30 minutes) ifTrue: [
		self error: self class cartIdIsExpired.
	].
	^ (carts at: cartId) value.! !

!CartsStore methodsFor: 'accessing' stamp: 'MC 6/16/2018 15:29:35'!
at: cartId put: cart on: currentTime
	carts at: cartId put: (currentTime -> cart).! !

!CartsStore methodsFor: 'accessing' stamp: 'MC 6/16/2018 15:30:59'!
includesKey: cartId
	^ carts includesKey: cartId.! !

!CartsStore methodsFor: 'accessing' stamp: 'MC 6/16/2018 15:32:06'!
isEmpty
	^ carts isEmpty.! !


!CartsStore methodsFor: 'initialization' stamp: 'MC 6/16/2018 15:30:09'!
initialize
	carts _ Dictionary new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartsStore class' category: #TusLibros!
CartsStore class
	instanceVariableNames: ''!

!CartsStore class methodsFor: 'error handling' stamp: 'MC 6/16/2018 15:46:23'!
cartIdIsExpired
	^ 'El carrito asociado a este id ha expirado'.! !

!CartsStore class methodsFor: 'error handling' stamp: 'MC 6/16/2018 15:49:11'!
invalidCartIdMessage
	^ 'El id del carrito es inválido'! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart creditCard salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'JA 6/12/2018 19:09:31'!
initializeToCheckout: aCart charging: aCreditCard registeringOn: aSalesBook debitingOn: aMerchantProcessor
	
	cart := aCart.
	creditCard := aCreditCard.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.! !


!Cashier methodsFor: 'checkout' stamp: 'JA 6/12/2018 19:44:47'!
checkOut
	
	| priceList total |
	
	priceList := cart catalog.
	total := 0.
	cart itemsDo: [ :anItem | total := total + (priceList at: anItem) ].

	self assertSufficientFunds: total onCreditCard: creditCard.

	merchantProcessor debitFrom: creditCard amount: total.
	salesBook add: (Sale of: total).
	
	^total! !


!Cashier methodsFor: 'assertions' stamp: 'JA 6/12/2018 19:44:42'!
assertSufficientFunds: funds onCreditCard: creditCard
	(merchantProcessor sufficientFunds: funds on: creditCard) ifFalse: [ self error: self class canNotChargeACreditCardWithInsufficientFundsMessage ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'JA 6/12/2018 09:07:50'!
toCheckout: aCart charging: aCreditCard on: aDate registeringOn: aSalesBook debitingOn: aMerchantProcessor
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	self assertMerchantProcessor: aMerchantProcessor doesNotReportStolen: aCreditCard.
	
	^self new initializeToCheckout: aCart charging: aCreditCard registeringOn: aSalesBook debitingOn: aMerchantProcessor.! !


!Cashier class methodsFor: 'assertions' stamp: 'JA 6/12/2018 08:18:57'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [ self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'JA 6/12/2018 09:19:54'!
assertMerchantProcessor: aMerchantProcessor doesNotReportStolen: aCreditCard.
	
	(aMerchantProcessor isStolen: aCreditCard) ifTrue: [ self error: self canNotChargeAStolenCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'error messages' stamp: 'JA 6/12/2018 19:20:17'!
canNotChargeACreditCardWithInsufficientFundsMessage
	^'Can not charge a credit card with insufficient funds'.! !

!Cashier class methodsFor: 'error messages' stamp: 'JA 6/12/2018 09:09:53'!
canNotChargeAStolenCreditCardErrorMessage
	
	^'Can not charge a stolen credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'queries' stamp: 'JA 6/12/2018 08:45:57'!
isExpiredOn: aDate 
	
	^expiration < aDate monthOfYear
	
	"^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start "! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !


!CreditCard methodsFor: 'inspecting' stamp: 'JA 6/17/2018 18:49:48'!
expiration
	^expiration! !

!CreditCard methodsFor: 'inspecting' stamp: 'JA 6/17/2018 18:49:30'!
number
	^number.! !

!CreditCard methodsFor: 'inspecting' stamp: 'JA 6/17/2018 18:50:01'!
owner
	^owner.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #RestApi category: #TusLibros!
Object subclass: #RestApi
	instanceVariableNames: 'catalog clients cartsStore'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestApi methodsFor: 'api' stamp: 'MC 6/16/2018 15:47:31'!
addToCart: cartId bookIsbn: isbn quantity: quantity on: creationTime
	(cartsStore at: cartId on: creationTime) add: quantity of: isbn.! !

!RestApi methodsFor: 'api' stamp: 'JA 6/17/2018 19:06:22'!
checkoutCart: cartId
creditCardNumber: creditCardNumber
creditCardExpiration: creditCardExpiration
creditCardOwner: creditCardOwner
on: time
	| cart creditCard |
	cart _ cartsStore at: cartId on: time.
	creditCard _ CreditCard of: creditCardOwner withNumber: creditCardNumber withExpiration: creditCardExpiration.
	"Cashier toCheckout: cart charging:  on:  registeringOn:  debitingOn: checkOut"
	^cartId.! !

!RestApi methodsFor: 'api' stamp: 'JA 6/17/2018 19:08:59'!
createCartFor: clientId with: password on: creationTime
	(clients includesKey: clientId) ifFalse: [ self error: self class invalidClientIdOrPasswordMessage ].
	(clients at: clientId) = password ifFalse: [ self error: self class invalidClientIdOrPasswordMessage ].
	cartsStore
		at: 'cart id'
		put: 'cart'
		on: creationTime.
	^ 'cart id'.! !

!RestApi methodsFor: 'api' stamp: 'JA 6/17/2018 18:12:56'!
listCart: cartId on: time
	| cart |
	cart _ cartsStore at: cartId on: time.
	^cart items inject: Dictionary new into: [ :list :item | list at: item put: (cart occurrencesOf: item); yourself ].! !


!RestApi methodsFor: 'initialization' stamp: 'MC 6/16/2018 14:29:46'!
withCatalog: aCatalog andClients: someClients storingOn: aCartsStore
	catalog := aCatalog.
	clients := someClients.
	cartsStore := aCartsStore.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestApi class' category: #TusLibros!
RestApi class
	instanceVariableNames: ''!

!RestApi class methodsFor: 'api' stamp: 'MC 6/16/2018 14:29:04'!
forCatalog: aCatalog andClients: clients storingOn: cartsStore
	^self new withCatalog: aCatalog andClients: clients storingOn: cartsStore! !


!RestApi class methodsFor: 'error handling' stamp: 'MC 6/16/2018 14:42:22'!
invalidClientIdOrPasswordMessage
	^ 'El id del cliente o su contraseña fueron incorrectos'.! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'inspection' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'JA 6/17/2018 18:08:48'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'JA 6/12/2018 08:44:39'!
expiredCreditCard
	| expirationDate |
	expirationDate _ today monthOfYear previousMonth: GregorianMonth january.
	^CreditCard expiringOn: expirationDate.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'JA 6/12/2018 08:44:33'!
notExpiredCreditCard
	| expirationDate |
	expirationDate _ today monthOfYear nextMonth: GregorianMonth january.
	^CreditCard expiringOn: expirationDate.! !


!StoreTestObjectsFactory methodsFor: 'items' stamp: 'JA 6/17/2018 18:07:56'!
anotherItemSellByTheStore
	^'another valid book'.! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'JA 6/17/2018 18:09:03'!
anotherItemSellByTheStorePrice
	
	^7! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'initialize' stamp: 'JA 6/17/2018 18:00:41'!
initialize

	today := FixedGregorianDate today.
	now := DateAndTime now.! !


!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'JA 6/17/2018 17:59:02'!
activeClient
	^'active client'.! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'JA 6/17/2018 17:59:16'!
activeClientPassword
	^'active client password'.! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'JA 6/17/2018 17:58:39'!
defaultClients
	^Dictionary new
		at: self activeClient
		put: self activeClientPassword;
		yourself.! !


!StoreTestObjectsFactory methodsFor: 'time' stamp: 'JA 6/17/2018 18:00:22'!
now
	^now.! !

!StoreTestObjectsFactory methodsFor: 'time' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
