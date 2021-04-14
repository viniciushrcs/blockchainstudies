pragma solidity ^0.5.10;

contract Tracking {

	enum Step { Supplier, SupplierToFactory, Factory, FactoryToStore }

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

	//Current Step
	// Will change over time
	Step public currentStep = Step.Supplier;

	//public é um modificador, para controlar acesso.
	function next() public {
 	  if (currentStep == Step.Supplier) {
 	  	supplierState++;
 	    if (supplierState == Finished) {
 	    	currentStep = Step.SupplierToFactory;
 	    }
 	    return;
 	  }
 	  if (currentStep == Step.SupplierToFactory) {
 	  	supplierToFactoryState++;
 	  	if (supplierToFactoryState == Finished) {
 	  		currentStep = Step.Factory;
 	  	}
 	  	return;
 	  }
 	   if (currentStep == Step.Factory) {
 	  	factoryState++;
 	  	if (factoryState == Finished) {
 	  		currentStep = Step.FactoryToStore;
 	  	}
 	  	return;
 	  }
 	   if (currentStep == Step.FactoryToStore) {
 	  	if (factoryToStoreState == Finished) {
 	  		//Revert é uma forma de encerrar o código e lançar um erro para o usuário
 	  		revert("Process is already finished");
 	  	}
 	  	factoryToStoreState++;
 	  	return;
 	  }
	}
}