!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #OOAbstractStack category: #'Stack-Exercise'!
Object subclass: #OOAbstractStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOAbstractStack methodsFor: 'inspecting' stamp: 'MC 4/16/2018 19:22:38'!
isEmpty
	self subclassResponsibility .! !

!OOAbstractStack methodsFor: 'inspecting' stamp: 'MC 4/16/2018 19:35:47'!
next
	self subclassResponsibility .! !

!OOAbstractStack methodsFor: 'inspecting' stamp: 'MC 4/16/2018 19:24:49'!
size
	self subclassResponsibility .! !

!OOAbstractStack methodsFor: 'inspecting' stamp: 'MC 4/16/2018 19:36:05'!
value
	self subclassResponsibility .! !


!classDefinition: #OOEmptyStack category: #'Stack-Exercise'!
OOAbstractStack subclass: #OOEmptyStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOEmptyStack methodsFor: 'inspecting' stamp: 'MC 4/16/2018 20:13:15'!
isEmpty
	^true .! !

!OOEmptyStack methodsFor: 'inspecting' stamp: 'JA 4/19/2018 18:53:05'!
next
	self error: (OOStack stackEmptyErrorDescription)! !

!OOEmptyStack methodsFor: 'inspecting' stamp: 'MC 4/16/2018 20:13:18'!
size
	^0 .! !

!OOEmptyStack methodsFor: 'inspecting' stamp: 'MC 4/16/2018 20:13:21'!
value
	self error: (OOStack stackEmptyErrorDescription) .! !


!classDefinition: #OOStackWithElements category: #'Stack-Exercise'!
OOAbstractStack subclass: #OOStackWithElements
	instanceVariableNames: 'next value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackWithElements methodsFor: 'initializing' stamp: 'MC 4/16/2018 20:12:47'!
initializeValue: aValue initializeNext: aNode
	value := aValue .
	next := aNode .! !


!OOStackWithElements methodsFor: 'inspecting' stamp: 'MC 4/16/2018 20:13:04'!
isEmpty
	^false .! !

!OOStackWithElements methodsFor: 'inspecting' stamp: 'MC 4/16/2018 20:13:01'!
next
	^next .! !

!OOStackWithElements methodsFor: 'inspecting' stamp: 'MC 4/16/2018 20:12:57'!
size
	^1 + (next size) .! !

!OOStackWithElements methodsFor: 'inspecting' stamp: 'MC 4/16/2018 20:12:54'!
value
	^value .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackWithElements class' category: #'Stack-Exercise'!
OOStackWithElements class
	instanceVariableNames: ''!

!OOStackWithElements class methodsFor: 'constructing' stamp: 'MC 4/16/2018 19:20:49'!
withValue: aValue withNext: aNode
	^self new
		initializeValue: aValue
		initializeNext: aNode.! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
!OOStack commentStamp: '<historical>' prior: 0!
!


!OOStack methodsFor: 'inspecting' stamp: 'MC 4/16/2018 20:13:37'!
isEmpty
	^head isEmpty .! !

!OOStack methodsFor: 'inspecting' stamp: 'MC 4/16/2018 20:13:40'!
size
	^head size .! !

!OOStack methodsFor: 'inspecting' stamp: 'MC 4/16/2018 20:13:43'!
top
	^head value .! !


!OOStack methodsFor: 'updating' stamp: 'MC 4/16/2018 20:13:50'!
pop
	| top |
	top := self top .
	head := head next .
	^top .! !

!OOStack methodsFor: 'updating' stamp: 'JA 4/19/2018 18:59:10'!
push: aValue
	head _ OOStackWithElements
		withValue: aValue
		withNext: head.! !


!OOStack methodsFor: 'constructing' stamp: 'JA 4/19/2018 18:58:40'!
initialize
	"Initialize a stack with the head value. We use an OOStackEmptyNode which follows the Null Object Pattern"
	head _ OOEmptyStack new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !
