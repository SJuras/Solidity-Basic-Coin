pragma solidity >=0.7.0 <0.9.0;

contract Coin {
    // address of the minter of the coin
    address public minter;

    mapping (address => uint) public balances;

    // event that logs the changes into blockchain
    event Sent(address from, address to, uint amount);


    constructor() {
        minter = msg.sender;
    }

    // minting (creating) function
    function mint(address receiver, uint amount) public {
        // only creator can mint coins
        require(msg.sender == minter);
        require(amount < 1e60);
        balances[receiver] += amount;
    }

    // send coins between addresses
    function send(address receiver, uint amount) public {
        // confirm that user has amount in the wallet
        require(amount <= balances[msg.sender], "Insufficient balance");

        // remove amount from sender balance + add value to receiver wallet
        balances[msg.sender] -= amount;
        balances[receiver] += amount;

        // emit event
        emit Sent(msg.sender, receiver, amount);
    }
}
