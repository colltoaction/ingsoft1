!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'MC 6/17/2018 20:27:42'!
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

!CartTest methodsFor: 'tests' stamp: 'MC 6/17/2018 20:27:30'!
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
	instanceVariableNames: 'testObjectsFactory debitFromBlock stolenCreditCardBlock sufficientFundsOnCreditCardBlock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestApiTest methodsFor: 'setup' stamp: 'JA 6/17/2018 21:36:40'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitFromBlock := [ :p1 :p2 | ].
	stolenCreditCardBlock := [ :p1 | false ].
	sufficientFundsOnCreditCardBlock := [ :p1 :p2 | true ].! !


!RestApiTest methodsFor: 'testing-create cart' stamp: 'JA 6/17/2018 21:35:14'!
test01CreateCartWithValidClientIdAndPassword
	| api cartId market cart |
	market _ testObjectsFactory defaultMarketWithMerchantProcessor: self.
	api _ RestApi forMarket: market.
	cartId _ api
		createCartFor: testObjectsFactory activeClient
		with: testObjectsFactory activeClientPassword
		on: testObjectsFactory now.

	cart _ market cartWithId: cartId on: testObjectsFactory now.
	self assert: cart isEmpty.! !

!RestApiTest methodsFor: 'testing-create cart' stamp: 'JA 6/17/2018 21:35:20'!
test02CannotCreateCartWithValidClientIdAndInvalidPassword
	| api market |
	market _ testObjectsFactory defaultMarketWithMerchantProcessor: self.
	api _ RestApi forMarket: market.
	self
		should: [
			api
				createCartFor: testObjectsFactory activeClient
				with: 'invalid password'
				on: testObjectsFactory now ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Market invalidClientIdOrPasswordMessage. ].! !

!RestApiTest methodsFor: 'testing-create cart' stamp: 'JA 6/17/2018 21:35:23'!
test03CannotCreateCartWithInvalidClientId
	| api market |
	market _ testObjectsFactory defaultMarketWithMerchantProcessor: self.
	api _ RestApi forMarket: market.
	self
		should: [
			api
				createCartFor: 'invalid client id'
				with: testObjectsFactory activeClientPassword
				on: testObjectsFactory now ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Market invalidClientIdOrPasswordMessage. ].! !


!RestApiTest methodsFor: 'testing-add to cart' stamp: 'JA 6/17/2018 21:35:28'!
test04AddToCartWithValidParameters
	| api market cart cartId |
	market _ testObjectsFactory defaultMarketWithMerchantProcessor: self.
	api _ RestApi forMarket: market.
	
	cartId _ market
		createCartForClientWithCredentials: testObjectsFactory activeClient -> testObjectsFactory activeClientPassword
		on: testObjectsFactory now.
	api
		addToCart: cartId
		bookIsbn: testObjectsFactory itemSellByTheStore
		quantity: 2
		on: testObjectsFactory now.

	cart _ market cartWithId: cartId on: testObjectsFactory now.
	self assert: 2 equals: (cart occurrencesOf: testObjectsFactory itemSellByTheStore).	! !

!RestApiTest methodsFor: 'testing-add to cart' stamp: 'JA 6/17/2018 21:35:31'!
test05CannotAddToCartWithInvalidCartId
	| api market |
	market _ testObjectsFactory defaultMarketWithMerchantProcessor: self.
	api _ RestApi forMarket: market.
	
	self
		should: [
			api
				addToCart: 'invalid cart id'
				bookIsbn: testObjectsFactory itemSellByTheStore
				quantity: 2
				on: testObjectsFactory now ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CartsStore invalidCartIdMessage. ].! !

!RestApiTest methodsFor: 'testing-add to cart' stamp: 'JA 6/17/2018 21:35:34'!
test06CannotAddToCartInvalidIsbn
	| api market cart cartId |
	market _ testObjectsFactory defaultMarketWithMerchantProcessor: self.
	api _ RestApi forMarket: market.
	cartId _ market
		createCartForClientWithCredentials: testObjectsFactory activeClient -> testObjectsFactory activeClientPassword
		on: testObjectsFactory now.
	
	self
		should: [
			api
				addToCart: cartId
				bookIsbn: 'invalid isbn'
				quantity: 2
				on: testObjectsFactory now ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			cart _ market cartWithId: cartId on: testObjectsFactory now.
			self assert: cart isEmpty.
			self assert: anError messageText = cart invalidItemErrorMessage. ].! !

!RestApiTest methodsFor: 'testing-add to cart' stamp: 'JA 6/17/2018 21:35:39'!
test07CannotAddToCartInvalidQuantity
	| api market cart cartId |
	market _ testObjectsFactory defaultMarketWithMerchantProcessor: self.
	api _ RestApi forMarket: market.
	cartId _ market
		createCartForClientWithCredentials: testObjectsFactory activeClient -> testObjectsFactory activeClientPassword
		on: testObjectsFactory now.
	
	self
		should: [
			api
				addToCart: cartId
				bookIsbn: testObjectsFactory itemSellByTheStore
				quantity: -42
				on: testObjectsFactory now ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			cart _ market cartWithId: cartId on: testObjectsFactory now.
			self assert: cart isEmpty.
			self assert: anError messageText = cart invalidQuantityErrorMessage. ].! !

!RestApiTest methodsFor: 'testing-add to cart' stamp: 'JA 6/17/2018 21:35:42'!
test08CannotAddToCartAfter30Minutes
	| api market cart cartId |
	market _ testObjectsFactory defaultMarketWithMerchantProcessor: self.
	api _ RestApi forMarket: market.
	cartId _ market
		createCartForClientWithCredentials: testObjectsFactory activeClient -> testObjectsFactory activeClientPassword
		on: testObjectsFactory now.
	
	self
		should: [
			api
				addToCart: cartId
				bookIsbn: testObjectsFactory itemSellByTheStore
				quantity: 7
				on: (testObjectsFactory now next: (TimeUnits second with: 31)) ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CartsStore cartIdIsExpired.
			cart _ market cartWithId: cartId on: testObjectsFactory now.
			self assert: cart isEmpty. ].! !


!RestApiTest methodsFor: 'testing-list cart' stamp: 'JA 6/17/2018 21:35:47'!
test09ListCartReturnsCartItemsCorrectly
	| api cart itemList cartId market |
	market _ testObjectsFactory defaultMarketWithMerchantProcessor: self.
	api _ RestApi forMarket: market.
	
	cartId _ market
		createCartForClientWithCredentials: testObjectsFactory activeClient -> testObjectsFactory activeClientPassword
		on: testObjectsFactory now.
	cart _ market cartWithId: cartId on: testObjectsFactory now.
	cart add: 1 of: testObjectsFactory itemSellByTheStore.
	cart add: 2 of: testObjectsFactory anotherItemSellByTheStore.

	itemList _ api
		listCart: cartId
		on: testObjectsFactory now.
		
	self assert: 2 equals: itemList keys size.
	self assert: (itemList at: testObjectsFactory itemSellByTheStore) equals: 1.
	self assert: (itemList at: testObjectsFactory anotherItemSellByTheStore) equals: 2.! !

!RestApiTest methodsFor: 'testing-list cart' stamp: 'JA 6/17/2018 21:35:50'!
test10CannotListInvalidIdCart
	| api cart cartId market |
	market _ testObjectsFactory defaultMarketWithMerchantProcessor: self.
	api _ RestApi forMarket: market.
	
	cartId _ market
		createCartForClientWithCredentials: testObjectsFactory activeClient -> testObjectsFactory activeClientPassword
		on: testObjectsFactory now.
	cart _ market cartWithId: cartId on: testObjectsFactory now.
	cart add: 1 of: testObjectsFactory itemSellByTheStore.
	cart add: 2 of: testObjectsFactory anotherItemSellByTheStore.

	self should: [
		api
			listCart: 'invalid cart id'
			on: testObjectsFactory now ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CartsStore invalidCartIdMessage ].! !


!RestApiTest methodsFor: 'testing-checkout cart' stamp: 'JA 6/17/2018 21:35:54'!
test11SuccessfulCartCheckoutReturnsTransactionId
	| api cart cartId market creditCard transactionId |
	market _ testObjectsFactory defaultMarketWithMerchantProcessor: self.
	api _ RestApi forMarket: market.
	
	cartId _ market
		createCartForClientWithCredentials: testObjectsFactory activeClient -> testObjectsFactory activeClientPassword
		on: testObjectsFactory now.
	cart _ market cartWithId: cartId on: testObjectsFactory now.
	cart add: 1 of: testObjectsFactory itemSellByTheStore.		
		
	creditCard _ testObjectsFactory notExpiredCreditCard.
	
	transactionId _ api
		checkoutCart: cartId
		creditCardNumber: creditCard number
		creditCardExpiration: (self monthOfYearToApiFormat: creditCard expiration)
		creditCardOwner: creditCard owner
		on: testObjectsFactory now.
		
	self assert: transactionId > 0.! !

!RestApiTest methodsFor: 'testing-checkout cart' stamp: 'JA 6/17/2018 21:40:34'!
test12CannotCheckoutWithInvalidCartId
	| api market creditCard |
	market _ testObjectsFactory defaultMarketWithMerchantProcessor: self.
	api _ RestApi forMarket: market.
	
	creditCard _ testObjectsFactory notExpiredCreditCard.
	
	self
		should: [
			api
				checkoutCart: 'invalid cart id'
				creditCardNumber: creditCard number
				creditCardExpiration: (self monthOfYearToApiFormat: creditCard expiration)
				creditCardOwner: creditCard owner
				on: testObjectsFactory now. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CartsStore invalidCartIdMessage ].! !

!RestApiTest methodsFor: 'testing-checkout cart' stamp: 'JA 6/17/2018 23:48:29'!
test14CannotCheckoutWithCardWithBadExpirationFormat
	| api market creditCard cart cartId |
	market _ testObjectsFactory defaultMarketWithMerchantProcessor: self.
	api _ RestApi forMarket: market.
	
	cartId _ market
		createCartForClientWithCredentials: testObjectsFactory activeClient -> testObjectsFactory activeClientPassword
		on: testObjectsFactory now.
	cart _ market cartWithId: cartId on: testObjectsFactory now.
	cart add: 1 of: testObjectsFactory itemSellByTheStore.
	
	creditCard _ testObjectsFactory notExpiredCreditCard.
	
	self
		should: [
			api
				checkoutCart: cartId 
				creditCardNumber: creditCard number
				creditCardExpiration: '1/2017'
				creditCardOwner: creditCard owner
				on: testObjectsFactory now. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = RestApi badExpirationFormatMessage ].! !

!RestApiTest methodsFor: 'testing-checkout cart' stamp: 'JA 6/17/2018 23:54:43'!
test15CannotCheckoutWithCardWithBadOwnerFormat
	| api market creditCard cart cartId |
	market _ testObjectsFactory defaultMarketWithMerchantProcessor: self.
	api _ RestApi forMarket: market.
	
	cartId _ market
		createCartForClientWithCredentials: testObjectsFactory activeClient -> testObjectsFactory activeClientPassword
		on: testObjectsFactory now.
	cart _ market cartWithId: cartId on: testObjectsFactory now.
	cart add: 1 of: testObjectsFactory itemSellByTheStore.
	
	creditCard _ testObjectsFactory notExpiredCreditCard.
	
	self
		should: [
			api
				checkoutCart: cartId 
				creditCardNumber: creditCard number
				creditCardExpiration: (self monthOfYearToApiFormat: creditCard expiration)
				creditCardOwner: '1234567890123456789012345678901'
				on: testObjectsFactory now. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = CreditCard badOwnerFormatMessage ].! !


!RestApiTest methodsFor: 'private' stamp: 'JA 6/17/2018 21:26:26'!
monthOfYearToApiFormat: monthOfYear
	^(monthOfYear month number printStringBase: 10 length: 2 padded: true) , monthOfYear year number asString! !


!RestApiTest methodsFor: 'simulating' stamp: 'JA 6/17/2018 21:37:02'!
debitFrom: aCreditCard amount: anAmount
	debitFromBlock value: aCreditCard value: anAmount.! !

!RestApiTest methodsFor: 'simulating' stamp: 'JA 6/17/2018 21:37:14'!
isStolen: aCreditCard
	^stolenCreditCardBlock value: aCreditCard.! !

!RestApiTest methodsFor: 'simulating' stamp: 'JA 6/17/2018 21:37:24'!
sufficientFunds: funds on: creditCard
	^sufficientFundsOnCreditCardBlock value: funds value: creditCard.! !


!RestApiTest methodsFor: 'testing-list purchases' stamp: 'JA 6/17/2018 22:41:32'!
test13ListPurchasesReturnsEveryPurchaseOfAClient
	| api market creditCard firstCartId firstCart secondCart secondCartId purchases |
	market _ testObjectsFactory defaultMarketWithMerchantProcessor: self.
	api _ RestApi forMarket: market.
	
	firstCartId _ market
		createCartForClientWithCredentials: (testObjectsFactory activeClient -> testObjectsFactory activeClientPassword)
		on: testObjectsFactory now.
	firstCart _ market cartWithId: firstCartId on: testObjectsFactory now.
	firstCart add: 1 of: testObjectsFactory itemSellByTheStore.
	
	secondCartId _ market
		createCartForClientWithCredentials: (testObjectsFactory activeClient -> testObjectsFactory activeClientPassword)
		on: testObjectsFactory now.
	secondCart _ market cartWithId: secondCartId on: testObjectsFactory now.
	secondCart add: 2 of: testObjectsFactory itemSellByTheStore.
	secondCart add: 1 of: testObjectsFactory anotherItemSellByTheStore.
	
	creditCard _ testObjectsFactory notExpiredCreditCard.
	
	market checkout: firstCart charging: creditCard on: testObjectsFactory now.
	market checkout: secondCart charging: creditCard on: testObjectsFactory now.
	
	purchases _ api
		listPurchasesOfClient: testObjectsFactory activeClient
		withPassword: testObjectsFactory activeClientPassword.
	
	self assert: (purchases key occurrencesOf: testObjectsFactory itemSellByTheStore) equals: 3.
	self assert: (purchases key occurrencesOf: testObjectsFactory anotherItemSellByTheStore) equals: 1.
	self assert: purchases value equals: (testObjectsFactory itemSellByTheStorePrice * 3) + (testObjectsFactory anotherItemSellByTheStorePrice).! !

!RestApiTest methodsFor: 'testing-list purchases' stamp: 'JA 6/18/2018 00:02:00'!
test16CannotListPurchasesWithInvalidClientId
	| api market |
	market _ testObjectsFactory defaultMarketWithMerchantProcessor: self.
	api _ RestApi forMarket: market.
	
	self
		should: [
			api
				listPurchasesOfClient: 'invalid client id'
				withPassword: testObjectsFactory activeClientPassword
		] raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Market invalidClientIdOrPasswordMessage ].! !

!RestApiTest methodsFor: 'testing-list purchases' stamp: 'JA 6/18/2018 00:02:39'!
test17CannotListPurchasesWithInvalidPassword
	| api market |
	market _ testObjectsFactory defaultMarketWithMerchantProcessor: self.
	api _ RestApi forMarket: market.
	
	self
		should: [
			api
				listPurchasesOfClient: testObjectsFactory activeClient
				withPassword: 'invalid password'
		] raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Market invalidClientIdOrPasswordMessage ].! !

!RestApiTest methodsFor: 'testing-list purchases' stamp: 'JA 6/18/2018 00:04:45'!
test18PurchasesListIsEmptyForNewClient
	| api market purchases |
	market _ testObjectsFactory defaultMarketWithMerchantProcessor: self.
	api _ RestApi forMarket: market.
	
	purchases _ api
		listPurchasesOfClient: testObjectsFactory activeClient
		withPassword: testObjectsFactory activeClientPassword.
	
	self assert: purchases key isEmpty.
	self assert: purchases value equals: 0.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'MC 6/17/2018 20:27:51'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'MC 6/17/2018 20:27:36'!
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

!CartsStore methodsFor: 'accessing' stamp: 'JA 6/17/2018 21:02:07'!
at: cartId on: currentTime
	| lastUsageTime |
	(carts includesKey: cartId) ifFalse: [
		self error: self class invalidCartIdMessage
	].
	lastUsageTime _ (carts at: cartId) key.
	currentTime > (lastUsageTime next: (TimeUnits second with: 30)) ifTrue: [
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


!CreditCard methodsFor: 'initialization' stamp: 'JA 6/17/2018 20:53:52'!
withOwner: anOwner withNumber: aNumber withExpiration: aMonthOfYear 
	owner _ anOwner.
	number _ aNumber.
	expiration _ aMonthOfYear.! !


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

!CreditCard class methodsFor: 'instance creation' stamp: 'JA 6/17/2018 23:53:33'!
of: anOwner withNumber: aNumber andExpiration: aMonthOfYear 
	(anOwner size <= 30) ifFalse: [ self error: self badOwnerFormatMessage ].
	^self new withOwner: anOwner withNumber: aNumber withExpiration: aMonthOfYear.! !


!CreditCard class methodsFor: 'error handling' stamp: 'JA 6/17/2018 23:54:18'!
badOwnerFormatMessage
	^'Nombre del dueño de la tarjeta muy largo'! !


!classDefinition: #Market category: #TusLibros!
Object subclass: #Market
	instanceVariableNames: 'clients cartsStore catalog lastCartId salesBook merchantProcessor lastTransactionId clientOfCart purchases'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!Market methodsFor: 'initialization' stamp: 'JA 6/17/2018 22:38:20'!
withClients: someClients andCatalog: aCatalog andMerchantProcessor: aMerchantProcessor
	lastCartId _ 0.
	lastTransactionId _ 0.
	cartsStore _ CartsStore new.
	clients _ someClients.
	catalog _ aCatalog.
	salesBook _ OrderedCollection new.
	merchantProcessor _ aMerchantProcessor.
	purchases _ Dictionary new.
	clientOfCart _ Dictionary new.! !


!Market methodsFor: 'cart' stamp: 'MC 6/17/2018 20:00:35'!
cartWithId: cartId on: currentTime 
	^cartsStore at: cartId on: currentTime.! !

!Market methodsFor: 'cart' stamp: 'JA 6/17/2018 22:38:00'!
createCartForClientWithCredentials: credentials on: creationTime 
	| cartId cart |
	self checkValidCredentials: credentials.
	cartId _ self generateCartId.
	cart _ (Cart acceptingItemsOf: catalog).
	cartsStore
		at: cartId
		put: cart
		on: creationTime.
	clientOfCart at: cart put: credentials key.
	^ cartId.! !

!Market methodsFor: 'cart' stamp: 'MC 6/17/2018 20:08:26'!
generateCartId
	lastCartId _ lastCartId + 1.
	^lastCartId.! !


!Market methodsFor: 'checkout' stamp: 'JA 6/17/2018 22:25:34'!
checkout: aCart charging: aCreditCard on: currentTime
	| cashier |
	cashier _ Cashier toCheckout: aCart charging: aCreditCard on: currentTime registeringOn: salesBook debitingOn: merchantProcessor.
	cashier checkOut.
	self registerPurchases: aCart.
	^self generateTransactionId.! !

!Market methodsFor: 'checkout' stamp: 'JA 6/17/2018 21:38:50'!
generateTransactionId
	lastTransactionId _ lastTransactionId + 1.
	^lastTransactionId.! !


!Market methodsFor: 'purchases' stamp: 'JA 6/18/2018 00:06:44'!
purchasesOf: credentials
	| clientPurchases totalAmount |
	self checkValidCredentials: credentials.
	clientPurchases _ purchases at: credentials key ifAbsent: [ Bag new ].
	totalAmount _ clientPurchases inject: 0 into: [ :sum :item | sum + catalog at: item ].
	^(clientPurchases -> totalAmount)! !

!Market methodsFor: 'purchases' stamp: 'JA 6/17/2018 22:30:19'!
registerPurchases: aCart
	| clientPurchases |
	clientPurchases _ purchases at: (clientOfCart at: aCart) ifAbsentPut: [ Bag new ].
	clientPurchases addAll: aCart items.! !


!Market methodsFor: 'assertions' stamp: 'JA 6/17/2018 22:04:26'!
checkValidCredentials: credentials
	(clients includesKey: credentials key) ifFalse: [ self error: self class invalidClientIdOrPasswordMessage ].
	(clients at: credentials key) = credentials value ifFalse: [ self error: self class invalidClientIdOrPasswordMessage ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Market class' category: #TusLibros!
Market class
	instanceVariableNames: ''!

!Market class methodsFor: 'initialization' stamp: 'JA 6/17/2018 21:34:31'!
forClients: clients andCatalog: catalog andMerchantProcessor: merchantProcessor
	^self new withClients: clients andCatalog: catalog andMerchantProcessor: merchantProcessor.! !


!Market class methodsFor: 'error handling' stamp: 'MC 6/17/2018 20:13:26'!
invalidClientIdOrPasswordMessage
	^ 'El id del cliente o su contraseña fueron incorrectos'.! !


!classDefinition: #RestApi category: #TusLibros!
Object subclass: #RestApi
	instanceVariableNames: 'market'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestApi methodsFor: 'api' stamp: 'MC 6/17/2018 20:21:00'!
addToCart: cartId bookIsbn: isbn quantity: quantity on: creationTime
	| cart |
	cart _ market cartWithId: cartId on: creationTime.
	cart add: quantity of: isbn.! !

!RestApi methodsFor: 'api' stamp: 'JA 6/17/2018 23:52:08'!
checkoutCart: cartId
creditCardNumber: creditCardNumber
creditCardExpiration: creditCardExpiration
creditCardOwner: creditCardOwner
on: currentTime
	| cart creditCard expiration |
	cart _ market cartWithId: cartId on: currentTime.
	expiration _ self expirationToMonthOfYear: creditCardExpiration.
	creditCard _ CreditCard of: creditCardOwner withNumber: creditCardNumber andExpiration: expiration.
	^market checkout: cart charging: creditCard on: currentTime.! !

!RestApi methodsFor: 'api' stamp: 'JA 6/17/2018 22:12:30'!
createCartFor: clientId with: password on: creationTime
	| credentials |
	credentials _ clientId -> password.
	^ market createCartForClientWithCredentials: credentials on: creationTime.! !

!RestApi methodsFor: 'api' stamp: 'MC 6/17/2018 20:35:48'!
listCart: cartId on: currentTime
	| cart |
	cart _ market cartWithId: cartId on: currentTime.
	^cart items inject: Dictionary new into: [ :list :item | list at: item put: (cart occurrencesOf: item); yourself ].! !

!RestApi methodsFor: 'api' stamp: 'JA 6/17/2018 22:02:33'!
listPurchasesOfClient: clientId withPassword: clientPassword
	^market purchasesOf: (clientId -> clientPassword).! !


!RestApi methodsFor: 'initialization' stamp: 'MC 6/17/2018 19:59:15'!
withMarket: aMarket
	market _ aMarket.! !


!RestApi methodsFor: 'input' stamp: 'JA 6/17/2018 23:47:32'!
expirationToMonthOfYear: expirationString
	| year month |
	(expirationString size = 6 and: [ expirationString allSatisfy: [ :char | char isDigit ]]) ifFalse: [
		self error: self class badExpirationFormatMessage
	].
	year _ (expirationString copyFrom: 3 to: 6) asNumber.
	month _ (expirationString copyFrom: 1 to: 2) asNumber.
	[ ^GregorianMonthOfYear yearNumber: year monthNumber: month ]
		on: Exception
		do: [ self error: self class badExpirationFormatMessage ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestApi class' category: #TusLibros!
RestApi class
	instanceVariableNames: ''!

!RestApi class methodsFor: 'initialization' stamp: 'MC 6/17/2018 19:35:14'!
forMarket: aMarket 
	^self new withMarket: aMarket.! !


!RestApi class methodsFor: 'error handling' stamp: 'JA 6/17/2018 23:30:28'!
badExpirationFormatMessage
	^'Formato incorrecto para el mes de expiración de la tarjeta'! !


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


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'JA 6/17/2018 21:39:46'!
expiredCreditCard
	| expirationDate |
	expirationDate _ today monthOfYear previousMonth: GregorianMonth january.
	^CreditCard of: self activeClient withNumber: '54000000000001' andExpiration: expirationDate.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'JA 6/17/2018 21:29:38'!
notExpiredCreditCard
	| expirationDate |
	expirationDate _ today monthOfYear nextMonth: GregorianMonth january.
	^CreditCard of: self activeClient withNumber: '54000000000001' andExpiration: expirationDate.! !


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


!StoreTestObjectsFactory methodsFor: 'initialize' stamp: 'JA 6/17/2018 20:58:10'!
initialize

	today := FixedGregorianDate today.
	now := GregorianDateTime now.! !


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


!StoreTestObjectsFactory methodsFor: 'market' stamp: 'JA 6/17/2018 21:33:47'!
defaultMarketWithMerchantProcessor: merchantProcessor
	^ Market forClients: self defaultClients andCatalog: self defaultCatalog andMerchantProcessor: merchantProcessor.! !
