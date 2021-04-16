pragma solidity ^0.5.10;

contract Store {
	// Owner do contrato
	// Detém os direitos do contrato
	// Contrato só armazena os valores de maneira temporária; o pagamento irá para o Owner
	address payable public owner;

	//Variáveis de controle da loja
	uint256 public price;
	uint256 public stock;

	//Controle de pontos
	mapping(address => uint256) points;
	address[] buyers;

	//Solidity events give an abstraction on top of the EVM’s logging functionality. Applications can subscribe and listen to these events through the RPC interface of an Ethereum client.

	event NewSale(address indexed _buyer, uint256 _points);
	event ChangeReceipt(address indexed _buyer, uint256 _change);

	constructor(uint256 _stock, uint256 _price) public {
		owner = msg.sender;
		stock = _stock;
		price = _price;
	}

	function buy() payable public {
		require(stock > 0, "There are no products avaiable.");
		require(msg.value >= price, "Value does not afford price.");

		uint256 change = msg.value%price;
		if(change > 0) {
			msg.sender.transfer(change);
			emit ChangeReceipt(msg.sender, change);
		}

		owner.transfer(msg.value-change);

		uint256 reward = msg.value/price;

		if(points[msg.sender] == 0) buyers.push(msg.sender);
		points[msg.sender] += reward;

		emit NewSale(msg.sender, reward);

		//Type cast - setar o int do valor, pois o reward é diferente do stock.
		stock -= uint64(reward);
	}

	//view é um método de leitura, não escreve no contrato. Não gera custos.
	function getPoints() public	view returns(uint256) {
		uint256 total = 0;
		for(uint i=0; i<buyers.length; i++) {
			total += points[ buyers[i] ];
		}
		return total;
	}

	function getBalance(address buyer) public view returns(uint256) {
		return points[buyer];
	}
}


