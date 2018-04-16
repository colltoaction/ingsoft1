!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #IdiomTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #IdiomTest
	instanceVariableNames: 'customerBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!IdiomTest methodsFor: 'testing' stamp: 'JA 4/12/2018 20:01:03'!
setUp
	customerBook := CustomerBook  new.! !


!classDefinition: #ErrorTests category: #'CodigoRepetido-Ejercicio'!
IdiomTest subclass: #ErrorTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!ErrorTests methodsFor: 'testing' stamp: 'JA 4/12/2018 21:11:40'!
should: aBlockClosure failWithError: error andAssert: assertionsClosure
	[ aBlockClosure value.
	self fail ]
		on: error
		do: [ :anError | assertionsClosure value: anError]! !

!ErrorTests methodsFor: 'testing' stamp: 'JA 4/12/2018 21:13:12'!
test03CanNotAddACustomerWithEmptyName
	self
		should: [customerBook addCustomerNamed: '']
		failWithError: Error
		andAssert: [:error | 
			self assert: error messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty].! !

!ErrorTests methodsFor: 'testing' stamp: 'JA 4/12/2018 21:15:01'!
test04CanNotRemoveAnInvalidCustomer	
	| name |

	name := 'John Lennon'.
	customerBook addCustomerNamed: name.
		
	self
		should: [customerBook removeCustomerNamed: 'Paul McCartney']
		failWithError: NotFound
		andAssert: [:error | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: name)].! !


!classDefinition: #TimeTests category: #'CodigoRepetido-Ejercicio'!
IdiomTest subclass: #TimeTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!TimeTests methodsFor: 'testing' stamp: 'JA 4/12/2018 21:02:25'!
assertThat: aBlockClosure shouldTakeLessThanMilliseconds: time
	| millisecondsSpent |
	millisecondsSpent := self millisecondsSpentToRun: aBlockClosure value.
	self assert: millisecondsSpent < time.! !

!TimeTests methodsFor: 'testing' stamp: 'JA 4/12/2018 20:59:43'!
millisecondsSpentToRun: aBlockClosure
	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue.
	aBlockClosure value.
	millisecondsAfterRunning := Time millisecondClockValue.
	
	^(millisecondsAfterRunning-millisecondsBeforeRunning)! !

!TimeTests methodsFor: 'testing' stamp: 'JA 4/12/2018 21:02:53'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	self assertThat: [customerBook addCustomerNamed: 'John Lennon'] shouldTakeLessThanMilliseconds: 50.! !

!TimeTests methodsFor: 'testing' stamp: 'JA 4/12/2018 21:03:07'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	| name |
	name := 'Paul McCartney'.
	customerBook addCustomerNamed: name.
	self assertThat: [customerBook removeCustomerNamed: name] shouldTakeLessThanMilliseconds: 100.! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:56'!
includesCustomerNamed: aName

	^customers includes: aName ! !

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:48'!
isEmpty
	
	^customers isEmpty  ! !


!CustomerBook methodsFor: 'initialization' stamp: 'HernanWilkinson 7/6/2011 17:42'!
initialize

	super initialize.
	customers := OrderedCollection new! !


!CustomerBook methodsFor: 'customer management' stamp: 'MC 4/16/2018 17:16:37'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:56'!
numberOfCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HAW 4/14/2017 16:55:43'!
removeCustomerNamed: aName
 
	customers remove: aName ifAbsent: [ NotFound signal ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
