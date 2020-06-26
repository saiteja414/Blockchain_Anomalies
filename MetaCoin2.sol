pragma solidity >=0.4.25 <0.7.0;

//Considering read and write as atomic functions

contract MetaCoin2 {
	mapping (address => uint) balances;

	event Transfer(address indexed _from, address indexed _to, uint256 _value);

	constructor() public {
		balances[msg.sender] = 100000;
	}

	function sendCoin(address receiver, uint amount) public returns(bool sufficient) {
		if (balances[msg.sender] < amount) return false;
		balances[msg.sender] -= amount;
		balances[receiver] += amount;
		emit Transfer(msg.sender, receiver, amount);
		return true;
	}

	function read(address sender) public view returns(uint256 bal) {
		return balances[sender];
	}

	function write(address receiver, uint amount) public returns(bool sufficient) {
		balances[receiver] = amount;
		return true;
	}

	function getBalance(address addr) public view returns(uint) {
		return balances[addr];
	}
}
