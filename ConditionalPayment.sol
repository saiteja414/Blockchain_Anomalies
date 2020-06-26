pragma solidity >=0.4.25 <0.7.0;

contract conditionalPayment {
uint32 public paid; // to keep track of the amount paid by Alice when deciding on Bob’s transfer 
mapping (address => uint256) public balances; // map addresses to their respective balance 
address A = 0x4dc25C5833525e90CD6b012265a394F2cc92E4d8; // the address of Alice’s account 
address B = 0x34DED4A2D428dA6BeE6495b4F70907Ab3B82c3f2; // the address of Bob’s account

event Transfer(address indexed _from, address indexed _to, uint256 _value);

modifier onlyFrom(address _address) { // enables execution of functions depending on invoker 
	if (msg.sender != _address) revert();
	_;
}

function checkPayment(address B, uint32 _amount) onlyFrom(B) public view returns (bool result) {
	if (paid > _amount) { // check that Alice paid
		return true; }
	else return false;
}

function sendTo(address B, uint32 _amount) onlyFrom(A) public{ // Alice sends money to Bob 
	balances[A] -= _amount;
	balances[B] += _amount;
	paid = _amount; // sorting the amount paid
	emit Transfer(msg.sender, B, _amount);

}

function sendIfReceived(address C, uint32 _amount) onlyFrom(B) public{ // Bob sends money to Carole 
	balances[B] -= _amount;
	balances[C] += _amount;
	emit Transfer(msg.sender, C, _amount); 
}

function getBalance(address addr) public view returns(uint) {
		return balances[addr];
}

}