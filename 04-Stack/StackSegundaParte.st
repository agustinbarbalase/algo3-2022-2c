!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 18:00:02'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:57'!
test02PushAddElementsToTheStack

	| stack |
	stack := OOStack new.
	
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:50'!
test03PopRemovesElementsFromTheStack

	| stack |
	stack := OOStack new.
	stack push: 'something'.
	
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:43'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: pushedObject equals: stack pop! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:56:59'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: secondPushedObject equals: stack pop.
	self assert: firstPushedObject equals: stack pop.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 18:00:26'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: pushedObject equals: stack top.
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:27'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: 1 equals: stack size.
	stack top.
	self assert: 1 equals: stack size.
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:44'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:56'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:07'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'sentenceOne sentenceTwo sentenceThree sentenceFour sentenceFive sentenceSix sentenceSeven sentenceEight prefixRi prefixBo prefixRa prefixSan prefixEmpty prefixWithEmptySpace prefixri prefixrI'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'AB 10/14/2022 12:28:33'!
test01SentenceFinderEmptyNoMatching
	| finder |
	finder := SentenceFinderByPrefix new.
	self
		should: [ finder find: prefixRi ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: SentenceFinderByPrefix sentenceFinderEmptyErrorDescription equals: anError messageText ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'AB 10/14/2022 12:28:44'!
test02SentenceFinderHadObjectsNoMatching
	| finder |
	finder := SentenceFinderByPrefix new.
	
	finder add: sentenceOne.
	finder remove.
	
	self
		should: [ finder find: prefixRi ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: SentenceFinderByPrefix sentenceFinderEmptyErrorDescription equals: anError messageText ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'AB 10/14/2022 12:28:57'!
test03SentenceFinderWithAObjectShouldMatch
	| finder selected |
	
	finder := SentenceFinderByPrefix new.
	selected := OrderedCollection new.
	
	selected add: sentenceOne.
	finder add: sentenceOne.
	
	self assert: ((finder find: prefixRi) = selected).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'AB 10/14/2022 12:29:11'!
test04SentenceFinderWithAObjectShouldNotMatch
	| finder |
	
	finder := SentenceFinderByPrefix new.
	finder add: sentenceOne.
	
	self
		should: [ finder find: prefixBo ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: SentenceFinderByPrefix sentenceFinderDoNotMatchErrorDescription equals: anError messageText ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'AB 10/14/2022 12:29:24'!
test05SentenceFinderWithSomeObjectShouldMatch
	| finder selected |
	
	finder := SentenceFinderByPrefix new.
	selected := OrderedCollection new.
	
	finder add: sentenceOne .
	finder add: sentenceTwo.
	finder add: sentenceThree.
	
	selected add: sentenceThree.
	
	self assert: ((finder find: prefixRa) = selected).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'AB 10/14/2022 12:29:40'!
test06SentenceFinderWithSomeObjectShouldNotMatch
	| finder |
	
	finder := SentenceFinderByPrefix new.
	
	finder add: sentenceOne.
	finder add: sentenceTwo.
	finder add: sentenceThree.
	
	self
		should: [ finder find: prefixSan ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: SentenceFinderByPrefix sentenceFinderDoNotMatchErrorDescription equals: anError messageText ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'AB 10/14/2022 12:29:52'!
test07ThePrefixShouldBeNotEmpty
	| finder |
	
	finder := SentenceFinderByPrefix new.
	
	finder add: sentenceOne.
	finder add: sentenceTwo.
	finder add: sentenceThree.
	
	self
		should: [ finder find: prefixEmpty ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: SentenceFinderByPrefix sentenceFinderPrefixCannotBeEmptyErrorDescription equals: anError messageText ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'AB 10/14/2022 12:30:08'!
test08ThePrefixShouldBeNotHaveEmptySpaces
	| finder |
	
	finder := SentenceFinderByPrefix new.
	
	finder add: sentenceOne.
	finder add: sentenceTwo.
	finder add: sentenceThree.
	
	self
		should: [ finder find: prefixWithEmptySpace ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: SentenceFinderByPrefix sentenceFinderPrefixCannotHasEmptySpacesErrorDescription equals: anError messageText ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'AB 10/14/2022 12:30:39'!
test09SentenceFinderIsCaseSensitive
	| finder selectedOne selectedTwo selectedThree |
	
	finder := SentenceFinderByPrefix new.
	selectedOne := OrderedCollection new.
	selectedTwo := OrderedCollection new.
	selectedThree := OrderedCollection new.
	
	selectedOne add: sentenceFour.
	selectedTwo add: sentenceOne.
	selectedThree add: sentenceFive.
	
	finder add: sentenceOne.
	finder add: sentenceFour.
	finder add: sentenceFive.
	
	self assert: ((finder find: prefixri) = selectedOne).
	self assert: ((finder find: prefixRi) = selectedTwo).
	self assert: ((finder find: prefixrI) = selectedThree).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'AB 10/14/2022 12:30:54'!
test10SentenceFinderIsLIFO
	| finder selected |
	
	finder := SentenceFinderByPrefix new.
	
	finder add: sentenceOne.
	finder add: sentenceTwo.
	finder add: sentenceThree.
	
	selected := OrderedCollection new.
	
	selected add: sentenceThree.
	
	self assert: ((finder find: prefixRa) = selected).
	
	self assert: sentenceThree equals: finder remove.
	self assert: sentenceTwo equals: finder remove.
	self assert: sentenceOne equals: finder remove.
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'AB 10/14/2022 12:34:49'!
test11SentenceFinderCanHaveMoreThatAMatchSentence
	| finder selected |
	
	finder := SentenceFinderByPrefix new.
	selected := OrderedCollection new.
	
	finder add: sentenceSix.
	finder add: sentenceSeven.
	finder add: sentenceEight.
	
	selected add: sentenceSix.
	selected add: sentenceEight.
	
	self assert: ((finder find: prefixRi) = selected).
	! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'AB 10/14/2022 12:33:57'!
setUp
	sentenceOne := 'River'.
	sentenceTwo := 'Boca'.
	sentenceThree := 'Racing'.
	sentenceFour := 'river'.
	sentenceFive := 'rIver'.
	sentenceSix := 'River le ganó a Boca'.
	sentenceSeven := 'Boca le ganó a River'.
	sentenceEight := 'River le ganó a Racing'.
	
	prefixRi := 'Ri'.
	prefixBo := 'Bo'.
	prefixRa := 'Ra'.
	prefixSan := 'San'.
	prefixEmpty := ''.
	prefixWithEmptySpace := 'Ri Bo'.
	prefixri := 'ri'.
	prefixrI := 'rI'.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'AB 10/13/2022 15:51:07'!
initialize
	top := Base new.
	size := 0.! !


!OOStack methodsFor: 'operations' stamp: 'AB 10/13/2022 15:38:19'!
pop
	| poppedElement |
	size := size - 1.
	poppedElement := top data.
	top := top remove.
	^poppedElement.! !

!OOStack methodsFor: 'operations' stamp: 'AB 10/13/2022 15:37:34'!
push: aString
	top := top addElement: aString.
	size := size + 1.! !

!OOStack methodsFor: 'operations' stamp: 'AB 10/13/2022 15:34:24'!
size
	^size.! !

!OOStack methodsFor: 'operations' stamp: 'AB 10/13/2022 15:34:59'!
top
	^top data.! !


!OOStack methodsFor: 'testing' stamp: 'AB 10/13/2022 15:35:39'!
isEmpty
	^(size <= 0)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'data'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'AB 10/13/2022 18:08:01'!
add: aSentence
	data push: aSentence.! !

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'AB 10/14/2022 12:39:21'!
find: aPrefix
	| stackAux selectedSentences currentSentece |
	
	data isEmpty ifTrue: [^self error: self class sentenceFinderEmptyErrorDescription].
	self isValidPrefix: aPrefix.
	
	stackAux := OOStack new.
	selectedSentences := OrderedCollection new.
	
	[ data isEmpty ] whileFalse: [
		currentSentece := data pop.
		( self match: currentSentece with: aPrefix ) ifTrue: [
			selectedSentences addFirst: currentSentece.
		].
		stackAux push: currentSentece.
	].

	data := self reverseStack: stackAux.
	
	(selectedSentences isEmpty) ifTrue: [^self error: self class sentenceFinderDoNotMatchErrorDescription].
	^selectedSentences.
	! !

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'AB 10/13/2022 17:27:14'!
remove
	^data pop.! !


!SentenceFinderByPrefix methodsFor: 'private - testing' stamp: 'AB 10/13/2022 18:14:10'!
hasEmptySpaces: aPrefix
	^((aPrefix findString: ' ' startingAt: 0) = 0) not.! !

!SentenceFinderByPrefix methodsFor: 'private - testing' stamp: 'AB 10/13/2022 18:15:24'!
isValidPrefix: aPrefix
	(aPrefix isEmpty) ifTrue: [^self error: self class sentenceFinderPrefixCannotBeEmptyErrorDescription].
	(self hasEmptySpaces: aPrefix) ifTrue: [^self error: self class sentenceFinderPrefixCannotHasEmptySpacesErrorDescription].! !

!SentenceFinderByPrefix methodsFor: 'private - testing' stamp: 'AB 10/13/2022 17:25:05'!
match: aSentence with: aPrefix
	^((aSentence size >= aPrefix size) and: (aSentence copyFrom: 1 to: aPrefix size) = aPrefix).
	! !


!SentenceFinderByPrefix methodsFor: 'private - operations' stamp: 'AB 10/14/2022 12:38:49'!
reverseStack: aStack
	| reversedStack |
	reversedStack := OOStack new.
	[ aStack isEmpty ] whileFalse: [	reversedStack push: (aStack pop)].
	^reversedStack.! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'AB 10/13/2022 16:00:18'!
initialize
	data := OOStack new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error description' stamp: 'AB 10/13/2022 16:21:47'!
sentenceFinderDoNotMatchErrorDescription
	^'SentenceFinder do not match with that prefix'! !

!SentenceFinderByPrefix class methodsFor: 'error description' stamp: 'AB 10/13/2022 16:09:48'!
sentenceFinderEmptyErrorDescription
	^'SentenceFinder is empty'! !

!SentenceFinderByPrefix class methodsFor: 'error description' stamp: 'AB 10/13/2022 16:32:09'!
sentenceFinderPrefixCannotBeEmptyErrorDescription
	^'Prefix cannot be empty'! !

!SentenceFinderByPrefix class methodsFor: 'error description' stamp: 'AB 10/13/2022 16:32:29'!
sentenceFinderPrefixCannotHasEmptySpacesErrorDescription
	^'Prefix cannot has empty spaces'! !


!classDefinition: #Top category: 'Stack-Exercise'!
Object subclass: #Top
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Top methodsFor: 'operations' stamp: 'AB 10/13/2022 15:50:19'!
addElement: aString
	^Element new initializeWith: aString aNextNode: self.! !

!Top methodsFor: 'operations' stamp: 'AB 10/13/2022 15:49:30'!
data
	self subclassResponsibility.! !

!Top methodsFor: 'operations' stamp: 'AB 10/13/2022 15:49:22'!
remove
	self subclassResponsibility.! !


!classDefinition: #Base category: 'Stack-Exercise'!
Top subclass: #Base
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Base methodsFor: 'operations' stamp: 'AB 10/13/2022 15:53:29'!
data
	^self stackEmptyError.! !

!Base methodsFor: 'operations' stamp: 'AB 10/13/2022 15:53:25'!
remove
	^self stackEmptyError.! !


!Base methodsFor: 'errors' stamp: 'AB 10/13/2022 15:53:14'!
stackEmptyError
	^self error: OOStack stackEmptyErrorDescription.! !


!classDefinition: #Element category: 'Stack-Exercise'!
Top subclass: #Element
	instanceVariableNames: 'data nextNode'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Element methodsFor: 'operations' stamp: 'AB 10/13/2022 15:32:51'!
data
	^data.
	! !

!Element methodsFor: 'operations' stamp: 'AB 10/13/2022 15:32:58'!
remove
	^nextNode! !


!Element methodsFor: 'initialization' stamp: 'AB 10/13/2022 15:32:10'!
initializeWith: aString aNextNode: aNode
	data := aString.
	nextNode := aNode.! !
