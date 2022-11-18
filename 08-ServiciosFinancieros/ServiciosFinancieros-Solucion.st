!classDefinition: #Tests category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #Tests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!


!classDefinition: #AccountSummaryTest category: 'ServiciosFinancieros-Solucion'!
Tests subclass: #AccountSummaryTest
	instanceVariableNames: 'expectedSummary01 expectedSummary02 expectedSummary03 expectedSummary04 expectedSummary05 account sender reciver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummaryTest methodsFor: 'setup' stamp: 'AB 11/17/2022 17:50:58'!
setUp
	account := ReceptiveAccount new.
	sender := ReceptiveAccount new.
	reciver := ReceptiveAccount new.
	
	expectedSummary01 := OrderedCollection with: 'Balance = 0 * pesos'.
	expectedSummary02 := OrderedCollection with: 'Depósito por 100 * pesos' with: 'Balance = 100 * pesos'.
	expectedSummary03 := OrderedCollection with: 'Extracción por 100 * pesos' with: 'Balance = -100 * pesos'.
	expectedSummary04 := OrderedCollection with: 'Entrada por transferencia de 100 * pesos' with: 'Balance = 100 * pesos'.
	expectedSummary05 := OrderedCollection with: 'Salida por transferencia de 100 * pesos' with: 'Balance = -100 * pesos'.! !


!AccountSummaryTest methodsFor: 'test' stamp: 'AB 11/17/2022 17:51:23'!
test01AnAccountWithoutTransactionReturnsZeroBalance
	self assert: expectedSummary01 equals: ((AccountSummary for: account) generate).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'AB 11/17/2022 17:51:43'!
test02AnAccountWithADepositReturnsDeposit
	
	Deposit register: 100 * peso on: account.
	
	self assert: expectedSummary02 equals: ((AccountSummary for: account) generate).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'AB 11/17/2022 17:52:10'!
test03AnAccountWithAWithdrawReturnsWithdraw
	
	Withdraw register: 100 * peso on: account.
	
	self assert: expectedSummary03 equals: ((AccountSummary for: account) generate).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'AB 11/17/2022 17:52:43'!
test04AnAccountWithATransferDepositReturnsTransferDeposit
	Transfer amount: 100 * peso from: sender to: reciver.
	
	self assert: expectedSummary04 equals: ((AccountSummary for: reciver) generate).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'AB 11/17/2022 17:53:03'!
test05AnAccountWithATransferWithdrawReturnsTransferWithdraw
	Transfer amount: 100 * peso from: sender to: reciver.
	
	self assert: expectedSummary05 equals: ((AccountSummary for: sender) generate).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'AB 11/17/2022 17:53:15'!
test06GetAccountSummaryForAPortfolioRaiseAnError
	self should: [AccountSummary for: (Portfolio new)] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: (AccountSummary cannotGetSummaryForPortfolioErrorDescription) equals: (anError messageText) ].! !


!classDefinition: #DetailedTreePrinterTest category: 'ServiciosFinancieros-Solucion'!
Tests subclass: #DetailedTreePrinterTest
	instanceVariableNames: 'expectedSummary04 expectedSummary03 expectedSummary02 expectedSummary01 myAccount johnsAccount angiesAccount childrenPortfolio familyPortfolio expectedSummary05 unnamedPortfolioOne unnamedPortfolioTwo unnamedReceptiveAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!DetailedTreePrinterTest methodsFor: 'setup' stamp: 'AB 11/17/2022 18:22:40'!
setUp
	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'. 
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.

	childrenPortfolio := Portfolio named: 'Portfolio de hijos'. 
	familyPortfolio := Portfolio named: 'Portfolio de la familia'.

	unnamedPortfolioOne := Portfolio new.
	unnamedPortfolioTwo := Portfolio new.
	unnamedReceptiveAccount := ReceptiveAccount new.

	expectedSummary01 := OrderedCollection new. 
	expectedSummary01 add: 'Portfolio de la familia'.
	expectedSummary01 add: '  Balance = 0 * pesos'.
	
	expectedSummary02 := OrderedCollection new.
	expectedSummary02 add: 'Portfolio de la familia'.
	expectedSummary02 add: '  Cuenta mia'.
	expectedSummary02 add: '    Depósito por 100 * pesos'.
	expectedSummary02 add: '    Balance = 100 * pesos'.	
	expectedSummary02 add: '  Balance = 100 * pesos'.

	expectedSummary03 := OrderedCollection new.
	expectedSummary03 add: 'Portfolio de la familia'.
	expectedSummary03 add: '  Portfolio de hijos'. 
	expectedSummary03 add: '    Cuenta de Juan'. 
	expectedSummary03 add: '      Depósito por 100 * pesos'.
	expectedSummary03 add: '      Balance = 100 * pesos'.
	expectedSummary03 add: '    Balance = 100 * pesos'.
	expectedSummary03 add: '  Balance = 100 * pesos'.

	expectedSummary04 := OrderedCollection new.
	expectedSummary04 add: 'Portfolio de la familia'.
	expectedSummary04 add: '  Cuenta mia'.
	expectedSummary04 add: '    Depósito por 100 * pesos'.
	expectedSummary04 add: '    Extracción por 40 * pesos'.
	expectedSummary04 add: '    Salida por transferencia de 50 * pesos'.
	expectedSummary04 add: '    Balance = 10 * pesos'.
	expectedSummary04 add: '  Portfolio de hijos'. 
	expectedSummary04 add: '    Cuenta de Juan'. 
	expectedSummary04 add: '      Depósito por 100 * pesos'.
	expectedSummary04 add: '      Extracción por 30 * pesos'.
	expectedSummary04 add: '      Balance = 70 * pesos'.
	expectedSummary04 add: '    Cuenta de Angeles'.
	expectedSummary04 add: '      Entrada por transferencia de 50 * pesos'.
	expectedSummary04 add: '      Balance = 50 * pesos'.
	expectedSummary04 add: '    Balance = 120 * pesos'.
	expectedSummary04 add: '  Balance = 130 * pesos'.
	
	expectedSummary05 := OrderedCollection new.
	expectedSummary05 add: 'Anonymous Portfolio'.
	expectedSummary05 add: '  Anonymous Portfolio'.
	expectedSummary05 add: '    Anonymous ReceptiveAccount'.
	expectedSummary05 add: '      Balance = 0 * pesos'.
	expectedSummary05 add: '    Balance = 0 * pesos'.
	expectedSummary05 add: '  Balance = 0 * pesos'.! !


!DetailedTreePrinterTest methodsFor: 'test' stamp: 'AB 11/17/2022 17:37:37'!
test01APortfolioWithoutAccountsPrintNameAndBalance
	self assert: expectedSummary01 equals: (DetailedTreePrinter for: familyPortfolio) generate.! !

!DetailedTreePrinterTest methodsFor: 'test' stamp: 'AB 11/17/2022 17:37:36'!
test02APortfolioWithAnAccountPrintThatAccount

	Deposit register: 100 * peso on: myAccount.
	familyPortfolio add: myAccount.
	
	self assert: expectedSummary02 equals: (DetailedTreePrinter for: familyPortfolio) generate.! !

!DetailedTreePrinterTest methodsFor: 'test' stamp: 'AB 11/17/2022 17:37:37'!
test03APortfolioWithChildPortfolioPrintTheAccountsOfTheChildPortfolio

	Deposit register: 100 * peso on: johnsAccount.
	childrenPortfolio add: johnsAccount.
	familyPortfolio add: childrenPortfolio.
		
	self assert: expectedSummary03 equals: (DetailedTreePrinter for: familyPortfolio) generate.! !

!DetailedTreePrinterTest methodsFor: 'test' stamp: 'AB 11/17/2022 17:37:37'!
test04APortfolioWithAccountsAndPortfoliosPrintAll

	Deposit register: 100 * peso on: johnsAccount.
	Withdraw register: 30 * peso on: johnsAccount.
	
	Deposit register: 100 * peso on: myAccount.
	Withdraw register: 40 * peso on: myAccount.
	Transfer amount: 50 * peso from: myAccount to: angiesAccount.

	childrenPortfolio add: johnsAccount.
	childrenPortfolio add: angiesAccount.
	familyPortfolio add: myAccount.
	familyPortfolio add: childrenPortfolio.
	
	self assert: expectedSummary04 equals: (DetailedTreePrinter for: familyPortfolio) generate.! !

!DetailedTreePrinterTest methodsFor: 'test' stamp: 'AB 11/17/2022 17:46:52'!
test05DetailedTreePrinterForReceptiveAccountRaiseAnError
	
	self should: [DetailedTreePrinter for: myAccount] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: 
			[:anError | self assert: 
				(DetailedTreePrinter cannotGetDetailedTreePrinterForReceptiveAccountErrorDescription) equals: (anError messageText) 
			].! !

!DetailedTreePrinterTest methodsFor: 'test' stamp: 'AB 11/17/2022 18:23:16'!
test06AccountsWithoutNamesPrintAnonymousPortfolioOrReceptiveAccount
	
	unnamedPortfolioTwo add: unnamedReceptiveAccount.
	unnamedPortfolioOne add: unnamedPortfolioTwo.
	
	self assert: expectedSummary05 equals: ((DetailedTreePrinter for: unnamedPortfolioOne) generate).! !


!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Solucion'!
Tests subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTest methodsFor: 'test' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'test' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'test' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'test' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'test' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'test' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'test' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'test' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'test' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Solucion'!
Tests subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccountTest methodsFor: 'test' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'test' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'test' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'test' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'test' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'test' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'test' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferNetTest category: 'ServiciosFinancieros-Solucion'!
Tests subclass: #TransferNetTest
	instanceVariableNames: 'expectedSummary01 expectedSummary02 expectedSummary03 account sender reciver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferNetTest methodsFor: 'test' stamp: 'AB 11/17/2022 17:56:51'!
setUp
	account := ReceptiveAccount new.
	sender := ReceptiveAccount new.
	reciver := ReceptiveAccount new.

	expectedSummary01 := 'Neto de transferencias = 0 * pesos'.
	expectedSummary02 := 'Neto de transferencias = 100 * pesos'.
	expectedSummary03 := 'Neto de transferencias = -100 * pesos'.! !

!TransferNetTest methodsFor: 'test' stamp: 'AB 11/17/2022 17:57:05'!
test01AnAccountWithoutTransfersReturnZeroTransferNet
	self assert: expectedSummary01 equals: ((TransferNet for: account) generate).! !

!TransferNetTest methodsFor: 'test' stamp: 'AB 11/17/2022 17:57:16'!
test02AnAccountWithTransferDepositReturnsTransferDeposit	
	
	Transfer amount: 100 * peso from: sender to: reciver.

	self assert: expectedSummary02 equals: ((TransferNet for: reciver) generate).! !

!TransferNetTest methodsFor: 'test' stamp: 'AB 11/17/2022 17:57:27'!
test03AnAccountWithTransferWithdrawReturnsTransferWithdraw
	
	Transfer amount: 100 * peso from: sender to: reciver.

	self assert: expectedSummary03 equals: ((TransferNet for: sender) generate).! !

!TransferNetTest methodsFor: 'test' stamp: 'AB 11/17/2022 17:56:26'!
test04GetTransferNetForAPortfolioRaiseAnError	
	self should: [TransferNet for: Portfolio new] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: (TransferNet cannotGetTransferNetForPortfolioErrorDescription) equals: (anError messageText) ].! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Solucion'!
Tests subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferTest methodsFor: 'test' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'test' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'test' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'test' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'test' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'test' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #TreePrinterTest category: 'ServiciosFinancieros-Solucion'!
Tests subclass: #TreePrinterTest
	instanceVariableNames: 'expectedSummary01 expectedSummary02 expectedSummary03 expectedSummary04 myAccount johnsAccount angiesAccount familyPortfolio childrenPortfolio expectedSummary05 unnamedPortfolioTwo unnamedReceptiveAccount unnamedPortfolioOne'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TreePrinterTest methodsFor: 'setup' stamp: 'AB 11/17/2022 18:24:43'!
setUp
	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'. 
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.	
	
	familyPortfolio := Portfolio named: 'Portfolio de la familia'.
	childrenPortfolio := Portfolio named: 'Portfolio de hijos'.	

	unnamedPortfolioOne := Portfolio new.
	unnamedPortfolioTwo := Portfolio new.
	unnamedReceptiveAccount := ReceptiveAccount new.

	expectedSummary01 := OrderedCollection with: 'Portfolio de la familia'.

	expectedSummary02 := OrderedCollection 
		with: 'Portfolio de la familia'
		with: '  Cuenta de Juan'.

	expectedSummary03 := OrderedCollection new.
	expectedSummary03 add: 'Portfolio de la familia'.
	expectedSummary03 add: '  Cuenta mia'.
	expectedSummary03 add: '  Portfolio de hijos'.

	expectedSummary04 := OrderedCollection new.
	expectedSummary04 add: 'Portfolio de la familia'.
	expectedSummary04 add: '  Cuenta mia'.
	expectedSummary04 add: '  Portfolio de hijos'.
	expectedSummary04 add: '    Cuenta de Juan'.
	expectedSummary04 add: '    Cuenta de Angeles'.
	
	expectedSummary05 := OrderedCollection new.
	expectedSummary05 add: 'Anonymous Portfolio'.
	expectedSummary05 add: '  Anonymous Portfolio'.
	expectedSummary05 add: '    Anonymous ReceptiveAccount'.! !


!TreePrinterTest methodsFor: 'test' stamp: 'AB 11/17/2022 17:35:29'!
test01APortfolioWithoutAccountsPrintTheNameOfPortfolio
	self assert: expectedSummary01 equals: (TreePrinter for: familyPortfolio) generate.! !

!TreePrinterTest methodsFor: 'test' stamp: 'AB 11/17/2022 17:35:46'!
test02APortfolioWithAnAccountPrintTheNameOfBoths
	
	familyPortfolio add: johnsAccount.
	
	self assert: expectedSummary02 equals: (TreePrinter for: familyPortfolio) generate.! !

!TreePrinterTest methodsFor: 'test' stamp: 'AB 11/17/2022 17:36:39'!
test03APortfolioWithPortfolioAndAccountPrintAllNames
	
	familyPortfolio add: myAccount.
	familyPortfolio add: childrenPortfolio.
	
	self assert: expectedSummary03 equals: (TreePrinter for: familyPortfolio) generate.! !

!TreePrinterTest methodsFor: 'test' stamp: 'AB 11/17/2022 17:37:17'!
test04APortfolioWithAChildPortfolioPrintTheirAccounts

	childrenPortfolio add: johnsAccount.
	childrenPortfolio add: angiesAccount.
	
	familyPortfolio add: myAccount.
	familyPortfolio add: childrenPortfolio.
	
	self assert: expectedSummary04 equals: (TreePrinter for: familyPortfolio) generate.! !

!TreePrinterTest methodsFor: 'test' stamp: 'AB 11/17/2022 17:46:40'!
test05TreePrinterForReceptiveAccountRaiseAnError
	
	self should: [TreePrinter for: myAccount] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError | self assert: (TreePrinter cannotGetTreePrinterForReceptiveAccountErrorDescription) equals: (anError messageText) ].! !

!TreePrinterTest methodsFor: 'test' stamp: 'AB 11/17/2022 18:28:49'!
test06AccountsWithoutNamesPrintAnonymousPortfolioOrReceptiveAccount
	
	unnamedPortfolioTwo add: unnamedReceptiveAccount.
	unnamedPortfolioOne add: unnamedPortfolioTwo.
	
	self assert: expectedSummary05 equals: ((TreePrinter for: unnamedPortfolioOne) generate).! !


!classDefinition: #Account category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'visitor' stamp: 'AB 11/17/2022 16:22:00'!
accept: aVisitor
	self subclassResponsibility.! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'AB 11/16/2022 10:39:55'!
initializeNamed: aName
	name := aName.
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'AB 11/16/2022 10:43:29'!
initializeNamed: aName with: anAccount
	name := aName.
	accounts := OrderedCollection with: anAccount.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'AB 11/16/2022 10:36:22'!
initializeNamed: aName with: anAccount with: anAnotherAccount 
	name := aName.
	accounts := OrderedCollection with: anAccount with: anAnotherAccount.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'AB 11/16/2022 10:46:09'!
accountDo: aBlock
	accounts do: aBlock.! !

!Portfolio methodsFor: 'main protocol' stamp: 'AB 11/16/2022 09:53:18'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 * peso ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'AB 11/18/2022 10:43:41'!
name
	(name) ifNil: [^('Anonymous ', self class asString)].
	^name! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'visitor' stamp: 'AB 11/17/2022 16:21:20'!
accept: aVisitor
	^aVisitor visitPortfolio: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error description' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!Portfolio class methodsFor: 'instance creation' stamp: 'AB 11/16/2022 10:39:32'!
named: aName
	^self new initializeNamed: aName ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'AB 11/16/2022 10:42:59'!
named: aName with: anAccount
	^self new initializeNamed: aName with: anAccount ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'AB 11/16/2022 10:34:32'!
named: aName with: anAccount with: anAnotherAccount
	^self new initializeNamed: aName with: anAccount with: anAnotherAccount ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'AB 11/16/2022 10:34:02'!
initializeNamed: aName
	super initialize.
	name := aName.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'AB 11/16/2022 09:53:25'!
balance

	^transactions 
		inject: 0 * peso
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'AB 11/18/2022 10:43:29'!
name
	(name) ifNil: [^('Anonymous ', self class asString)].
	^name! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'AB 11/16/2022 10:23:03'!
transactionsDo: aBlock
	transactions do: aBlock! !


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'visitor' stamp: 'AB 11/17/2022 16:22:10'!
accept: aVisitor
	^aVisitor visitReceptiveAccount: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancieros-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'AB 11/16/2022 10:33:17'!
named: aName
	^self new initializeNamed: aName ! !


!classDefinition: #AccountReport category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Solucion'!
AccountReport subclass: #AccountSummary
	instanceVariableNames: 'receptiveAccount account summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummary methodsFor: 'initialization' stamp: 'AB 11/16/2022 10:19:21'!
initializeFor: anAccount
	summary := OrderedCollection new.
	account := anAccount.! !


!AccountSummary methodsFor: 'main protocol' stamp: 'AB 11/16/2022 10:22:40'!
generate
	account transactionsDo: [:anTransaction | anTransaction accept: self].
	summary add: ('Balance = ', account balance asString).
	^summary! !


!AccountSummary methodsFor: 'visitor' stamp: 'AB 11/16/2022 10:15:55'!
visitDeposit: aVisit
	summary add: ('Depósito por ', aVisit value asString).! !

!AccountSummary methodsFor: 'visitor' stamp: 'AB 11/16/2022 10:18:02'!
visitTransferDepositLeg: aVisit
	summary add: ('Entrada por transferencia de ', aVisit value asString)! !

!AccountSummary methodsFor: 'visitor' stamp: 'AB 11/16/2022 10:17:44'!
visitTransferWithdrawLeg: aVisit
	summary add: ('Salida por transferencia de ', aVisit value asString)! !

!AccountSummary methodsFor: 'visitor' stamp: 'AB 11/16/2022 10:19:06'!
visitWithdraw: aVisit
	summary add: ('Extracción por ', aVisit value asString)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'ServiciosFinancieros-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'AB 11/17/2022 16:45:57'!
for: anAccount
	self isValidAccount: anAccount.
	^self new initializeFor: anAccount ! !


!AccountSummary class methodsFor: 'error description' stamp: 'AB 11/17/2022 16:45:27'!
cannotGetSummaryForPortfolioErrorDescription
	^'Cannot get summary for portfolio'! !


!AccountSummary class methodsFor: 'valid' stamp: 'AB 11/17/2022 16:45:27'!
isValidAccount: anAccount 
	(anAccount isKindOf: ReceptiveAccount) ifTrue: [^self].
	^self error: (self cannotGetSummaryForPortfolioErrorDescription).! !


!classDefinition: #DetailedTreePrinter category: 'ServiciosFinancieros-Solucion'!
AccountReport subclass: #DetailedTreePrinter
	instanceVariableNames: 'portfolio summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!DetailedTreePrinter methodsFor: 'initialization' stamp: 'AB 11/16/2022 11:34:21'!
initializeFor: aPortfolio
	portfolio := aPortfolio.
	summary := OrderedCollection new.! !


!DetailedTreePrinter methodsFor: 'main protocol' stamp: 'AB 11/18/2022 10:44:37'!
generate
	summary add: (portfolio name).
	portfolio accountDo: [:anAccount | anAccount accept: self].
	summary add: ('  Balance = ', portfolio balance asString).
	^summary.! !


!DetailedTreePrinter methodsFor: 'visitor' stamp: 'AB 11/17/2022 18:17:29'!
visitPortfolio: aPortfolio
	((DetailedTreePrinter for: aPortfolio) generate) do: [:DetailedTreePrinterLine |
		summary add: ('  ', DetailedTreePrinterLine	)
	]! !

!DetailedTreePrinter methodsFor: 'visitor' stamp: 'AB 11/18/2022 10:44:57'!
visitReceptiveAccount: aReceptiveAccount
	summary add: ('  ', (aReceptiveAccount name)).
	((AccountSummary for: aReceptiveAccount) generate) do: [:aTransaction |
		summary add: ('    ', aTransaction).	
	]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DetailedTreePrinter class' category: 'ServiciosFinancieros-Solucion'!
DetailedTreePrinter class
	instanceVariableNames: ''!

!DetailedTreePrinter class methodsFor: 'instance creation' stamp: 'AB 11/17/2022 17:42:38'!
for: anAccount
	self isValidAccount: anAccount.
	^self new initializeFor: anAccount ! !


!DetailedTreePrinter class methodsFor: 'valid' stamp: 'AB 11/17/2022 17:45:29'!
isValidAccount: anAccount 
	(anAccount isKindOf: Portfolio) ifTrue: [^self].
	^self error: (self cannotGetDetailedTreePrinterForReceptiveAccountErrorDescription).
	! !


!DetailedTreePrinter class methodsFor: 'error description' stamp: 'AB 11/17/2022 17:45:29'!
cannotGetDetailedTreePrinterForReceptiveAccountErrorDescription
	^'Cannot get detailed tree printer for receptive account'! !


!classDefinition: #TransferNet category: 'ServiciosFinancieros-Solucion'!
AccountReport subclass: #TransferNet
	instanceVariableNames: 'account transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferNet methodsFor: 'initialization' stamp: 'AB 11/17/2022 17:02:52'!
initializeFor: anAccount
	account := anAccount.
	transferNet := 0 * peso.! !


!TransferNet methodsFor: 'main protocol' stamp: 'AB 11/17/2022 17:02:30'!
generate
	account transactionsDo: [:anTransaction | anTransaction accept: self ].
	^('Neto de transferencias = ', transferNet asString).! !


!TransferNet methodsFor: 'visitor' stamp: 'AB 11/16/2022 10:24:22'!
visitDeposit: aVisit! !

!TransferNet methodsFor: 'visitor' stamp: 'AB 11/17/2022 17:00:35'!
visitTransferDepositLeg: aVisit
	transferNet := aVisit affectBalance: transferNet.! !

!TransferNet methodsFor: 'visitor' stamp: 'AB 11/17/2022 17:00:40'!
visitTransferWithdrawLeg: aVisit
	transferNet := aVisit affectBalance: transferNet.! !

!TransferNet methodsFor: 'visitor' stamp: 'AB 11/16/2022 10:24:30'!
visitWithdraw: aVisit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'ServiciosFinancieros-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'AB 11/17/2022 16:49:01'!
for: anAccount
	self isValidAccount: anAccount.
	^self new initializeFor: anAccount ! !


!TransferNet class methodsFor: 'valid' stamp: 'AB 11/17/2022 16:49:40'!
isValidAccount: anAccount 
	(anAccount isKindOf: ReceptiveAccount) ifTrue: [^self].
	^self error: (self cannotGetTransferNetForPortfolioErrorDescription).! !


!TransferNet class methodsFor: 'error description' stamp: 'AB 11/17/2022 16:50:22'!
cannotGetTransferNetForPortfolioErrorDescription
	^'Cannot get transfer net for portfolio'! !


!classDefinition: #TreePrinter category: 'ServiciosFinancieros-Solucion'!
AccountReport subclass: #TreePrinter
	instanceVariableNames: 'portfolio summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TreePrinter methodsFor: 'initialization' stamp: 'AB 11/16/2022 11:31:25'!
initializeFor: aPortfolio
	portfolio := aPortfolio.
	summary := OrderedCollection new.! !


!TreePrinter methodsFor: 'main protocol' stamp: 'AB 11/18/2022 10:44:00'!
generate
	summary add: (portfolio name).
	portfolio accountDo: [:anAccount | anAccount accept: self].
	^summary.! !


!TreePrinter methodsFor: 'visitor' stamp: 'AB 11/16/2022 11:30:10'!
visitPortfolio: aPortfolio
	(TreePrinter for: aPortfolio) generate do: [:anTreePrinterLine |
		summary add: ('  ', anTreePrinterLine).	
	]! !

!TreePrinter methodsFor: 'visitor' stamp: 'AB 11/18/2022 10:44:20'!
visitReceptiveAccount: aReceptiveAccount
	summary add: ('  ', (aReceptiveAccount name)).	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TreePrinter class' category: 'ServiciosFinancieros-Solucion'!
TreePrinter class
	instanceVariableNames: ''!

!TreePrinter class methodsFor: 'instance creation' stamp: 'AB 11/17/2022 17:39:59'!
for: anAccount
	self isValidAccount: anAccount.
	^self new initializeFor: anAccount ! !


!TreePrinter class methodsFor: 'valid' stamp: 'AB 11/17/2022 17:46:26'!
isValidAccount: anAccount 
	(anAccount isKindOf: Portfolio) ifTrue: [^self].
	self error: (self cannotGetTreePrinterForReceptiveAccountErrorDescription).! !


!TreePrinter class methodsFor: 'error description' stamp: 'AB 11/17/2022 17:46:26'!
cannotGetTreePrinterForReceptiveAccountErrorDescription
	^'Cannot get tree printer for receptive account'! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'visitor' stamp: 'AB 11/16/2022 10:20:18'!
accept: aVisitor
	aVisitor visitDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDepositLeg methodsFor: 'visitor' stamp: 'AB 11/16/2022 10:20:28'!
accept: aVisitor
	aVisitor visitTransferDepositLeg: self.! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!TransferWithdrawLeg methodsFor: 'visitor' stamp: 'AB 11/16/2022 10:20:33'!
accept: aVisitor
	aVisitor visitTransferWithdrawLeg: self.! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'visitor' stamp: 'AB 11/16/2022 10:20:39'!
accept: aVisitor
	aVisitor visitWithdraw: self.! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
