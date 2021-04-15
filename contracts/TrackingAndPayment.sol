pragma solidity ^0.5.10;

import './Tracking.sol';

//Rastreamento e pagamento
// O `is` estende os métodos do Tracking para o Tracking and Payment
contract TrackingAndPayment is Tracking {
	// Deve-se declarar payable para um endereço poder receber pagamentos
	address payable public supplier;
	address payable public factory;

	//Aceitação
	bool public supplierAccept;
	bool public factoryAccept;
	bool public storeAccept;

	//Quanto cada um tem para receber
	uint256 public supplierBalance;
	uint256 public factoryBalance;

	constructor(address payable _supplier, address payable _factory, address _store) Tracking(_supplier, _factory, _store) public {
		supplier = _supplier;
		factory = _factory;
	}

	//Metodo para depósitos
	function deposit() payable public {
		require(msg.sender == factory || msg.sender == store, "Only factory and store accounts are allowed to deposit");

		if(msg.sender == factory) supplierBalance += msg.value;
		if(msg.sender == store) factoryBalance += msg.value;
	}

	function accept() public {
		if(msg.sender == supplier) supplierAccept = true;
		if(msg.sender == factory) factoryAccept = true;
		if(msg.sender == store) storeAccept = true;
	}

	function next() public {
		require(supplierAccept && factoryAccept && storeAccept, "All roles must accept to proceed");

		super.next();

		pay();
	}

	function pay() payable public {
		if(factoryState == Finished && supplierBalance > 0) {
			supplier.transfer(supplierBalance);
			supplierBalance = 0;
		}
		if(storeVerificationState == Finished && factoryBalance > 0) {
			factory.transfer(factoryBalance);
			factoryBalance = 0;
		}
	}
}