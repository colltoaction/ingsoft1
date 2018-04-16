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


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
!OOStack commentStamp: '<historical>' prior: 0!
This is the empty stack for now, but we might want to change some names!


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

!OOStack methodsFor: 'updating' stamp: 'MC 4/16/2018 20:13:53'!
push: aValue
	head := OOStackNode withValue: aValue withNext: head .! !


!OOStack methodsFor: 'constructing' stamp: 'MC 4/16/2018 20:13:30'!
initialize
	"Initialize a stack with the head value. We use an OOStackEmptyNode which follows the Null Object Pattern"
	head := OOStackEmptyNode new .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackAbstractNode category: #'Stack-Exercise'!
Object subclass: #OOStackAbstractNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackAbstractNode methodsFor: 'inspecting' stamp: 'MC 4/16/2018 19:22:38'!
isEmpty
	self subclassResponsibility .! !

!OOStackAbstractNode methodsFor: 'inspecting' stamp: 'MC 4/16/2018 19:35:47'!
next
	self subclassResponsibility .! !

!OOStackAbstractNode methodsFor: 'inspecting' stamp: 'MC 4/16/2018 19:24:49'!
size
	self subclassResponsibility .! !

!OOStackAbstractNode methodsFor: 'inspecting' stamp: 'MC 4/16/2018 19:36:05'!
value
	self subclassResponsibility .! !


!classDefinition: #OOStackEmptyNode category: #'Stack-Exercise'!
OOStackAbstractNode subclass: #OOStackEmptyNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackEmptyNode methodsFor: 'inspecting' stamp: 'MC 4/16/2018 20:13:15'!
isEmpty
	^true .! !

!OOStackEmptyNode methodsFor: 'inspecting' stamp: 'MC 4/16/2018 20:13:18'!
size
	^0 .! !

!OOStackEmptyNode methodsFor: 'inspecting' stamp: 'MC 4/16/2018 20:13:21'!
value
	self error: (OOStack stackEmptyErrorDescription) .! !


!classDefinition: #OOStackNode category: #'Stack-Exercise'!
OOStackAbstractNode subclass: #OOStackNode
	instanceVariableNames: 'next value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNode methodsFor: 'initializing' stamp: 'MC 4/16/2018 20:12:47'!
initializeValue: aValue initializeNext: aNode
	value := aValue .
	next := aNode .! !


!OOStackNode methodsFor: 'inspecting' stamp: 'MC 4/16/2018 20:13:04'!
isEmpty
	^false .! !

!OOStackNode methodsFor: 'inspecting' stamp: 'MC 4/16/2018 20:13:01'!
next
	^next .! !

!OOStackNode methodsFor: 'inspecting' stamp: 'MC 4/16/2018 20:12:57'!
size
	^1 + (next size) .! !

!OOStackNode methodsFor: 'inspecting' stamp: 'MC 4/16/2018 20:12:54'!
value
	^value .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackNode class' category: #'Stack-Exercise'!
OOStackNode class
	instanceVariableNames: ''!

!OOStackNode class methodsFor: 'constructing' stamp: 'MC 4/16/2018 19:20:49'!
withValue: aValue withNext: aNode
	^self new
		initializeValue: aValue
		initializeNext: aNode.! !
