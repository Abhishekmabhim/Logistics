pragma solidity ^0.8.16;
import "./seller.sol";
import "./logistic.sol";
contract Buyer{
    Seller s;
    address frght;
    address sllr;
    Freight L;

    function reqQuote(uint pid) public view returns (uint, string memory, string memory,  uint, bool, address){
        return s.reqQuote(pid);
    }

    function BookFreighter(uint OID) public payable {
        (,uint freighterPrice, address freightAccount) = L.bookff(OID, sllr);
        require(msg.value == freighterPrice, "invalidFund");
        (bool done,) = freightAccount.call{value: msg.value}("");
        require(done == true, "failed");
    }

    function choff(address _frght) public {
        frght = _frght;
        L = Frei(frght);
    }

    function Buy(uint pid, string memory name, string memory addss,uint40 ph, string memory email) public payable {address _Buyer = msg.sender;
        (uint num, address _seller) = s.Buy(pid,_Buyer,name,addss,ph,email);
        require(msg.value == num, "Low Fund");
        (bool success,) = (_seller).call{value: msg.value}("");
        require(success,"Buy failed!");
    }
    function chosell(address _sllr) public {
        sllr = _sllr;
        s = Seller(_sllr);
    }

}