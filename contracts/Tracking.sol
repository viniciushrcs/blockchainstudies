pragma solidity ^0.5.10;

contract Tracking {

	enum Step { Supplier, SupplierToFactory, Factory, FactoryToStore, StoreVerification}

	//State of each step
	//Unsigned Integer - no solidity não temos sinais negativos
	//int8....int256 - vai afetar o consumo de hardware que afeta o Gas
	uint8 constant Waiting = 0;
	uint8 constant Running = 1;
	uint8 constant Finished = 2;

	//Steps
	//Etapas da cadeia de valor
	// Supplier -> Factory -> Store
	//Não declarar valor inicial é igual a iniciar com valor 0, ou seja, Waiting.
	uint8 public supplierState;
	uint8 public supplierToFactoryState;
	uint8 public factoryState;
	uint8 public factoryToStoreState;
	uint8 public storeVerificationState;

	//Current Step
	// Will change over time
	Step public currentStep = Step.Supplier;

	//Roles
	//address - controle de endereços
	address public supplier;
	address public factory;
	address public store;

	//Contract creation
	constructor(address _supplier, address _factory, address _store) public {
		supplier = _supplier;
		factory = _factory;
		store = _store;
	}

	//public é um modificador, para controlar acesso.
	function next() public {
 	  if (currentStep == Step.Supplier) {
 	  	if(msg.sender != supplier) revert("User not allowed");
 	  	supplierState++;
 	    if (supplierState == Finished) {
 	    	currentStep = Step.SupplierToFactory;
 	    }
 	    return;
 	  }
 	  if (currentStep == Step.SupplierToFactory) {
 	  	if(msg.sender != supplier) revert("User not allowed");
 	  	supplierToFactoryState++;
 	  	if (supplierToFactoryState == Finished) {
 	  		currentStep = Step.Factory;
 	  	}
 	  	return;
 	  }
 	   if (currentStep == Step.Factory) {
 	  	if(msg.sender != factory) revert("User not allowed");
 	  	factoryState++;
 	  	if (factoryState == Finished) {
 	  		currentStep = Step.FactoryToStore;
 	  	}
 	  	return;
 	  }
 	   if (currentStep == Step.FactoryToStore) {
 	  	if(msg.sender != factory) revert("User not allowed");
 	  	factoryToStoreState++;
 	  	if (factoryToStoreState == Finished) {
 	  		currentStep = Step.StoreVerification;
 	  	}
 	  	return;
 	  }
 	   if (currentStep == Step.StoreVerification) {
 	  	if(msg.sender != store) revert("User not allowed");
 	  	if (storeVerificationState == Finished) {
 	  		//Revert é uma forma de encerrar o código e lançar um erro para o usuário
 	  		revert("Process is already finished");
 	  	}
 	  	storeVerificationState++;
 	  	return;
 	  }
	}
}