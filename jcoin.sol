pragma solidity ^0.4.17;
contract Jcoin{
    string public name = "Jcoin";
    string public symbol = "JC";
    uint8 public decimals = 0;
    uint16 public totalsupply = 1000;
    
    //mapping of user address to boolean values
    mapping (address => bool) public students;
    
    //mapping of user address to no of tokens
    mapping (address => uint16) public balances;
    
    //contract owner address
    address public owner;
    
    //Transfer event
    event Transfer(address indexed from,address indexed to,uint value);
    
    //constructor
    function Jcoin() public{
        owner = msg.sender;
        balances[owner] = totalsupply;
    }
    
    //isowner
    modifier isowner(){
        require (owner == msg.sender);
        _;
        
    }
    
    //approveStudents
    function approveStudents(address _address) public isowner{
        students[_address] = true;
    }
    
    
    //transfer
    function transfer(address _to,uint16 _value) public isowner payable{
        require(students[_to] == true);
        require (balances[msg.sender] >= _value);
        balances[owner] = balances[owner] - _value;
        balances[_to] = balances[_to] + _value;
        Transfer(owner, _to,_value);
    }
    //pay
    function pay(address _from,uint16 _value) public{
        balances[owner] = balances[owner] + _value;
        balances[_from] = balances[_from] - _value;
        Transfer(_from, owner, _value);
    }
    
    
    //balanceof
    function balanceof (address _address) public view returns(uint16){
        return balances[_address];
    }
    
    
}