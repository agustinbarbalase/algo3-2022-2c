!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'AB 11/10/2022 15:35:11'!
test01APortfolioWithoutAccountsHasABalanceEqualsToZero
	self assert: 0 * peso equals: (Portfolio new balance).! !

!PortfolioTest methodsFor: 'tests' stamp: 'AB 11/10/2022 15:35:43'!
test02APortfolioWithAccountAndWithTransactionHasBalance
	| portfolio account |

	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	Deposit register: 100 * peso on: account.
	
	portfolio addAccount: account.

	self assert: 100 * peso equals: (portfolio balance).! !

!PortfolioTest methodsFor: 'tests' stamp: 'AB 11/10/2022 15:36:30'!
test03APortfolioWithMoreAccountsHaveASumOfBalances
	| portfolio accountOne accountTwo |

	portfolio := Portfolio new.
	accountOne := ReceptiveAccount new.
	accountTwo := ReceptiveAccount new.
	
	Deposit register: 100 * peso on: accountOne.
	Deposit register: 100 * peso on: accountTwo.
		
	portfolio addAccount: accountOne.
	portfolio addAccount: accountTwo.

	self assert: 200 * peso equals: (portfolio balance).! !

!PortfolioTest methodsFor: 'tests' stamp: 'AB 11/10/2022 15:37:18'!
test04APortfolioWithAnAccountAndATransactionHasRegisteredThatTransaction
	| portfolio account transaction |

	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	transaction := Deposit register: 100 * peso on: account.
		
	portfolio addAccount: account.

	self assert: (portfolio hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'tests' stamp: 'AB 11/10/2022 15:38:35'!
test05APortfolioWithATransactionNotRegisterForAnAccountIsNotRegisterForPortfolio
	| portfolio account transactionOne transactionTwo |

	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	transactionOne := Deposit register: 100 * peso on: account.
	transactionTwo := Deposit for: 100 * peso.
		
	portfolio addAccount: account.

	self assert: (portfolio hasRegistered: transactionOne).
	self deny: (portfolio hasRegistered: transactionTwo).! !

!PortfolioTest methodsFor: 'tests' stamp: 'AB 11/10/2022 15:39:55'!
test06APortfolioWithMoreThanOneAccountHaveMoreTransactionRegister
	| portfolio accountOne accountTwo transactionOne transactionTwo |

	portfolio := Portfolio new.
	accountOne := ReceptiveAccount new.
	accountTwo := ReceptiveAccount new.
	
	transactionOne := Deposit register: 100 * peso on: accountOne.
	transactionTwo := Deposit register: 100 * peso on: accountTwo.
		
	portfolio addAccount: accountOne.
	portfolio addAccount: accountTwo.

	self assert: (portfolio hasRegistered: transactionOne).
	self assert: (portfolio hasRegistered: transactionTwo).! !

!PortfolioTest methodsFor: 'tests' stamp: 'AB 11/10/2022 15:41:00'!
test07APortfolioReturnAllTransactionsFromAllAccounts
	| portfolio accountOne accountTwo transactionOne transactionTwo transactions |

	portfolio := Portfolio new.
	accountOne := ReceptiveAccount new.
	accountTwo := ReceptiveAccount new.
	
	transactionOne := Deposit register: 100 * peso on: accountOne.
	transactionTwo := Deposit register: 100 * peso on: accountTwo.
	
	portfolio addAccount: accountOne.
	portfolio addAccount: accountTwo.

	transactions := OrderedCollection with: transactionOne with: transactionTwo.

	self assert: transactions equals: (portfolio transactions).! !


!PortfolioTest methodsFor: 'tests - extra' stamp: 'AB 11/10/2022 15:50:20'!
test08APortfolioCannotAddAnAccountAddedBefore
	| portfolio account |

	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio addAccount: account.
	
	self should: [portfolio addAccount: account] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: (Portfolio cannotAddThisAccountInPortfolioErrorDescription) equals: (anError messageText)].! !

!PortfolioTest methodsFor: 'tests - extra' stamp: 'AB 11/10/2022 15:50:20'!
test09APortfolioCannotAddAnAccountAddedBeforeForOtherPortfolio
	| portfolioRoot portfolioChild account |

	portfolioRoot := Portfolio new.
	portfolioChild := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolioChild addAccount: account.
	portfolioRoot addAccount: portfolioChild.
	
	self should: [portfolioRoot addAccount: account] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: (Portfolio cannotAddThisAccountInPortfolioErrorDescription) equals: (anError messageText)].! !

!PortfolioTest methodsFor: 'tests - extra' stamp: 'AB 11/10/2022 15:50:21'!
test10APortfolioCannotAddedItself
	| portfolio |

	portfolio := Portfolio new.
	
	self should: [portfolio addAccount: portfolio] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: (Portfolio cannotAddThisAccountInPortfolioErrorDescription) equals: (anError messageText)].! !

!PortfolioTest methodsFor: 'tests - extra' stamp: 'AB 11/10/2022 15:50:21'!
test11CannotAddAAccountIfThisIsChildFromAParentPortfolioThatHadThatAccount
	| portfolioRoot portfolioChild account |

	portfolioRoot := Portfolio new.
	portfolioChild := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolioRoot addAccount: account.
	portfolioRoot addAccount: portfolioChild.
	
	self should: [portfolioChild addAccount: account] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: (Portfolio cannotAddThisAccountInPortfolioErrorDescription) equals: (anError messageText)].! !

!PortfolioTest methodsFor: 'tests - extra' stamp: 'AB 11/10/2022 15:50:20'!
test12CannotAddAPortfolioToAnotherIfTheFirstHadAccountThatHadTheSecond
	| portfolioOne portfolioTwo account |

	portfolioOne := Portfolio new.
	portfolioTwo := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolioOne addAccount: account.
	portfolioTwo addAccount: account.
	
	self should: [portfolioOne addAccount: portfolioTwo] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: (Portfolio cannotAddThisAccountInPortfolioErrorDescription) equals: (anError messageText)].! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferenceTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferenceTest methodsFor: 'tests' stamp: 'AB 11/10/2022 15:27:06'!
test01ATransaferenceProduceAChangeInBothBalance
	| sender reciver |
	
	sender := ReceptiveAccount new.
	reciver := ReceptiveAccount new.
	
	Transference registerFor: 100 * peso from: sender to: reciver.
	
	self assert: -100 * peso equals: (sender balance).
	self assert: 100 * peso equals: (reciver balance).! !

!TransferenceTest methodsFor: 'tests' stamp: 'AB 11/10/2022 15:29:17'!
test02ATransferenceKnowsItsValue
	| sender reciver transaction |
	
	sender := ReceptiveAccount new.
	reciver := ReceptiveAccount new.
	
	transaction := Transference registerFor: 100 * peso from: sender to: reciver.
	
	self assert: 100 * peso equals: (transaction value).! !

!TransferenceTest methodsFor: 'tests' stamp: 'AB 11/10/2022 15:28:10'!
test03BothAccountsHasRegisteredTheirTransaference
	| sender reciver transaction reciverPart senderPart |
	
	sender := ReceptiveAccount new.
	reciver := ReceptiveAccount new.
	
	transaction := Transference registerFor: 100 * peso from: sender to: reciver.
	senderPart := transaction outputTransference.
	reciverPart := transaction inputTransference.
	
	self assert: (sender hasRegistered: senderPart).
	self assert: (reciver hasRegistered: reciverPart).! !

!TransferenceTest methodsFor: 'tests' stamp: 'AB 11/10/2022 15:31:59'!
test04BothTransferenceRegisterKnowsTheirCounterparts
	| sender reciver transaction reciverPart senderPart |
	
	sender := ReceptiveAccount new.
	reciver := ReceptiveAccount new.
	
	transaction := Transference registerFor: 100 * peso from: sender to: reciver.
	senderPart := transaction outputTransference.
	reciverPart := transaction inputTransference.
	
	self assert: reciverPart equals: (senderPart counterPart).
	self assert: senderPart equals: (reciverPart counterPart).! !

!TransferenceTest methodsFor: 'tests' stamp: 'AB 11/10/2022 15:30:36'!
test05BothTransferenceRegisterKnowsTheirValues
	| sender reciver transaction reciverPart senderPart |
	
	sender := ReceptiveAccount new.
	reciver := ReceptiveAccount new.
	
	transaction := Transference registerFor: 100 * peso from: sender to: reciver.
	senderPart := transaction outputTransference.
	reciverPart := transaction inputTransference.
	
	self assert: 100 * peso equals: (senderPart value).
	self assert: 100 * peso equals: (reciverPart value).! !

!TransferenceTest methodsFor: 'tests' stamp: 'AB 11/10/2022 15:31:05'!
test06ATransferenceWithZeroAmountThrowAError
	| sender reciver |
	
	sender := ReceptiveAccount new.
	reciver := ReceptiveAccount new.
	
	self should: [Transference registerFor: 0 * peso from: sender to: reciver] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [
			:anError | self assert: (Transference cannotTransferZeroOrNegativeAmountErrorDescription) equals: (anError messageText)
		].! !

!TransferenceTest methodsFor: 'tests' stamp: 'AB 11/10/2022 15:31:44'!
test07ATransferenceWithNegativeAmountThrowAError
	| sender reciver |
	
	sender := ReceptiveAccount new.
	reciver := ReceptiveAccount new.
	
	self should: [Transference registerFor: -100 * peso from: sender to: reciver] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [
			:anError | self assert: (Transference cannotTransferZeroOrNegativeAmountErrorDescription) equals: (anError messageText)
		].! !


!classDefinition: #AccountComponent category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountComponent
	instanceVariableNames: 'accounts parent'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountComponent methodsFor: 'main protocol' stamp: 'AB 11/9/2022 14:00:50'!
accounts
	self subclassResponsibility.! !

!AccountComponent methodsFor: 'main protocol' stamp: 'AB 11/9/2022 14:01:00'!
balance 
	self subclassResponsibility.! !

!AccountComponent methodsFor: 'main protocol' stamp: 'AB 11/9/2022 14:01:43'!
hasRegistered: aTransaction
	self subclassResponsibility.! !

!AccountComponent methodsFor: 'main protocol' stamp: 'AB 11/9/2022 14:01:17'!
transactions
	self subclassResponsibility.! !


!AccountComponent methodsFor: 'operations - private' stamp: 'AB 11/9/2022 14:00:42'!
setParent: anAccount
	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
AccountComponent subclass: #Portfolio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'main protocol' stamp: 'AB 11/11/2022 16:22:33'!
addAccount: aNewAccount
	(self isPossibleAdd: aNewAccount)	 ifFalse: [^self error: self class cannotAddThisAccountInPortfolioErrorDescription].
	accounts add: aNewAccount.
	aNewAccount setParent: self.! !

!Portfolio methodsFor: 'main protocol' stamp: 'AB 11/6/2022 15:57:48'!
balance
	| result |
	result := 0.
	accounts do: [:anAccount | result := result + anAccount balance].
	^result.! !

!Portfolio methodsFor: 'main protocol' stamp: 'AB 11/6/2022 15:58:14'!
hasRegistered: aTransaction
	^(accounts anySatisfy: [:anAccount | anAccount hasRegistered: aTransaction ]).! !

!Portfolio methodsFor: 'main protocol' stamp: 'AB 11/10/2022 15:51:52'!
transactions
	| transactions |
	transactions := OrderedCollection new.
	accounts do: [:anAccount | transactions addAll: anAccount transactions ].
	^transactions copy.! !


!Portfolio methodsFor: 'initialization' stamp: 'AB 11/6/2022 15:16:38'!
initialize
	accounts := OrderedCollection new.! !


!Portfolio methodsFor: 'operations - private' stamp: 'AB 11/9/2022 13:45:02'!
accounts
	| accountsWithSelf |
	
	accountsWithSelf := accounts copy.
	accountsWithSelf add: self.
	
	^accountsWithSelf.! !

!Portfolio methodsFor: 'operations - private' stamp: 'AB 11/9/2022 13:56:56'!
includes: anAccount
	^(self = anAccount) or: [accounts anySatisfy: [:aChildAccount | aChildAccount includes: anAccount]].! !

!Portfolio methodsFor: 'operations - private' stamp: 'AB 11/9/2022 13:50:18'!
isPossibleAdd: aNewAccount
	(aNewAccount accounts) do: [:anAccount |
		((self rootPortfolio) includes: anAccount) ifTrue: [^false].	
	].
	^true! !

!Portfolio methodsFor: 'operations - private' stamp: 'AB 11/9/2022 13:03:50'!
rootPortfolio
	parent ifNil: [^self].
	^parent rootPortfolio.! !

!Portfolio methodsFor: 'operations - private' stamp: 'AB 11/9/2022 13:00:32'!
setParent: anAccount
	parent := anAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error description' stamp: 'AB 11/10/2022 15:50:20'!
cannotAddThisAccountInPortfolioErrorDescription
	^'Cannot add this account in portfolio'! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
AccountComponent subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'AB 11/6/2022 13:11:32'!
balance
	| result |
	result := 0.
	transactions do: [:aTransaction |
		result := aTransaction resultInBalance: result.	
	].
	^result.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'operations - private' stamp: 'AB 11/9/2022 13:14:54'!
accounts
	^OrderedCollection with: self.! !

!ReceptiveAccount methodsFor: 'operations - private' stamp: 'AB 11/9/2022 12:21:55'!
includes: anAccount 
	^(self = anAccount).! !

!ReceptiveAccount methodsFor: 'operations - private' stamp: 'AB 11/9/2022 13:42:14'!
setParent: aParent! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'operations' stamp: 'AB 11/6/2022 13:12:55'!
resultInBalance: aResult
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'operations' stamp: 'AB 11/6/2022 13:12:07'!
resultInBalance: aResult
	^aResult + value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #InputTransference category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #InputTransference
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!InputTransference methodsFor: 'initialization' stamp: 'AB 11/6/2022 13:32:49'!
initializeOf: aTranference
	transference := aTranference.! !


!InputTransference methodsFor: 'operations' stamp: 'AB 11/6/2022 13:36:29'!
counterPart
	^transference outputTransference.! !

!InputTransference methodsFor: 'operations' stamp: 'AB 11/6/2022 13:35:44'!
resultInBalance: aResult
	^aResult + (transference value).! !


!InputTransference methodsFor: 'value' stamp: 'AB 11/6/2022 13:37:25'!
value
	^transference value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InputTransference class' category: 'ServiciosFinancieros-Ejercicio'!
InputTransference class
	instanceVariableNames: ''!

!InputTransference class methodsFor: 'instance creation' stamp: 'AB 11/6/2022 13:33:16'!
of: aTransference
	^self new initializeOf: aTransference.! !


!classDefinition: #OutputTransference category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #OutputTransference
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!OutputTransference methodsFor: 'initialization' stamp: 'AB 11/6/2022 13:33:31'!
initializeOf: aTransference
	transference := aTransference.! !


!OutputTransference methodsFor: 'operations' stamp: 'AB 11/6/2022 13:36:07'!
counterPart
	^transference inputTransference.! !

!OutputTransference methodsFor: 'operations' stamp: 'AB 11/6/2022 13:35:23'!
resultInBalance: aResult 
	^aResult - (transference value).! !


!OutputTransference methodsFor: 'value' stamp: 'AB 11/6/2022 13:37:12'!
value
	^transference value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OutputTransference class' category: 'ServiciosFinancieros-Ejercicio'!
OutputTransference class
	instanceVariableNames: ''!

!OutputTransference class methodsFor: 'instance creation' stamp: 'AB 11/6/2022 13:33:22'!
of: aTransference
	^self new initializeOf: aTransference.! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'operations' stamp: 'AB 11/6/2022 13:12:30'!
resultInBalance: aResult
	^aResult - value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transference category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transference
	instanceVariableNames: 'value inputTransference outputTransference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transference methodsFor: 'initialization' stamp: 'AB 11/6/2022 13:34:50'!
initializeFor: aValue 
	value := aValue.
	inputTransference := InputTransference of: self.
	outputTransference := OutputTransference of: self.! !

!Transference methodsFor: 'initialization' stamp: 'AB 11/6/2022 13:17:54'!
value
	^value! !


!Transference methodsFor: 'accessing' stamp: 'AB 11/6/2022 13:25:15'!
inputTransference
	^inputTransference! !

!Transference methodsFor: 'accessing' stamp: 'AB 11/6/2022 13:25:05'!
outputTransference
	^outputTransference! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'ServiciosFinancieros-Ejercicio'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'instance creation' stamp: 'AB 11/6/2022 13:42:16'!
registerFor: aValue from: aSender to: aReciver 
	| transaction |

	(aValue <= 0) ifTrue: [^self error: (self cannotTransferZeroOrNegativeAmountErrorDescription)].
	transaction := self new initializeFor: aValue.
	aSender register: (transaction outputTransference).
	aReciver register: (transaction inputTransference).	
	
	^transaction! !


!Transference class methodsFor: 'error description' stamp: 'AB 11/6/2022 13:42:16'!
cannotTransferZeroOrNegativeAmountErrorDescription
	^'Cannot transfer zero or negative amount'! !
