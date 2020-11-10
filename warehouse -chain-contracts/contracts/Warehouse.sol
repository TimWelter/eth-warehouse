pragma solidity 0.6.4;
pragma experimental ABIEncoderV2;


contract Warehouse {
    address public owner = msg.sender;
    mapping(address => bool) workerList;
    mapping(address => bool) readOnlyList;

    struct Location {
        uint256 locationNumber;
        bytes32 locationLetter;
    }

    struct Product {
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
        productStructs.push(Product(name, quantity,  Location(locationNumber, locationLetter)));
    }

}
