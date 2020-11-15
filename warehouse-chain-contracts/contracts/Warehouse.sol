pragma solidity 0.6.4;
pragma experimental ABIEncoderV2;


contract Warehouse {
    event AddProduct(address from, Product product, uint date);

    address public owner = msg.sender;
    mapping(address => bool) workerList;
    mapping(address => bool) readOnlyList;
    mapping(address => bytes32) usernameList;

    struct Location {
        uint256 locationNumber;
        bytes32 locationLetter;
    }

    struct Product {
        uint id;
        bytes32 name;
        uint256 quantity;
        Location location;
    }

    Product[] productStructs;

    constructor() public {
        addWorker(msg.sender);
        addReadOnly(msg.sender);

        addProduct("Product1", 10, 1, "A");
        addProduct("Product2", 10, 1, "B");
    }


    modifier onlyAdmin() {
        require(msg.sender == owner, "You are not authorized.");
        _;
    }

    modifier onlyWorker() {
        require(workerList[msg.sender], "You are not authorized");
        _;
    }

    modifier readOnly() {
        require(readOnlyList[msg.sender], "You are not authorized");
        _;
    }

    function setUsername(address _address, bytes32 name) public onlyAdmin {
        usernameList[_address] = name;
    }

    function chooseUsername(bytes32 name) public readOnly {
        usernameList[msg.sender] = name;
    }

    function getUsername() public view readOnly returns (bytes32) {
        return usernameList[msg.sender];
    }

    function addWorker(address _address) public onlyAdmin {
        readOnlyList[_address] = true;
        workerList[_address] = true;
    }

    function removeWorker(address _address) public onlyAdmin {
        readOnlyList[_address] = false;
        workerList[_address] = false;
    }

    function addReadOnly(address _address) public onlyAdmin {
        readOnlyList[_address] = true;
    }

    function removeReadOnly(address _address) public onlyAdmin {
        readOnlyList[_address] = false;
    }


    function getProductById(uint id) public view readOnly returns(Product memory) {
        return productStructs[id];
    }

    function getAllProducts() public view readOnly returns(Product[] memory) {
      return productStructs;
    }

    function addProduct(bytes32 name, uint256 quantity, uint256 locationNumber, bytes32 locationLetter) public onlyWorker {
        // uint id = 0;
        // if(productStructs.length != 0) {
        //     id = productStructs.length - 1;
        // }
        Product memory product = Product(productStructs.length, name, quantity,  Location(locationNumber, locationLetter));
        productStructs.push(product);
        emit AddProduct(msg.sender, product, now);
    }

    function checkOutProduct(uint id, uint amount) public onlyWorker returns (bool) {
        if(productStructs[id].quantity - amount >= 0) {
            productStructs[id].quantity -= amount;
            return true;
        } else {
            return false;
        }
    }

    function checkInProduct(uint id, uint amount) public onlyWorker {
        productStructs[id].quantity += amount;
    }

}
