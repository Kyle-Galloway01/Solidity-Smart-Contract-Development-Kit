
pragma solidity ^0.8.0;

contract Token {
    string public name;
    string public symbol;
    uint256 public totalSupply;
    uint8 public decimals;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(string memory _name, string memory _symbol, uint256 _totalSupply, uint8 _decimals) {
        name = _name;
        symbol = _symbol;
        totalSupply = _totalSupply;
        decimals = _decimals;
        balanceOf[msg.sender] = _totalSupply;
    }

    function transfer(address _To, uint256 _Value) external returns (bool) {
        require(_To != address(0), "Invalid address");
        require(balanceOf[msg.sender] >= _Value, "Insufficient balance");
        
        balanceOf[msg.sender] -= _Value;
        balanceOf[_To] += _Value;
        emit Transfer(msg.sender, _To, _Value);
        return true;
    }

    function approve(address _Spender, uint256 _Value) external returns (bool) {
        allowance[msg.sender][_Spender] = _Value;
        emit Approval(msg.sender, _Spender, _Value);
        return true;
    }

    function transferFrom(address _From, address _To, uint256 _Value) external returns (bool) {
        require(_From != address(0), "Invalid sender address");
        require(_To != address(0), "Invalid recipient address");
        require(balanceOf[_From] >= _Value, "Insufficient balance");
        require(allowance[_From][msg.sender] >= _Value, "Insufficient allowance");
        
        balanceOf[_From] -= _Value;
        balanceOf[_To] += _Value;
        allowance[_From][msg.sender] -= _Value;
        emit Transfer(_From, _To, _Value);
        return true;
    }
}
