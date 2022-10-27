pragma solidity >=0.7.0 <0.9.0;


contract Logistics{

    address public Saller;
    address public coustmer;
    address public Custom1;
    address public Custom2;
    address public Delivery;

    struct Packageitem{
        bool Approve;
        string orderStatus;

        string Customs1;
        string Customs2;
        
        string Delivery;
    }

    constructor (address _saller){
        Saller = _saller;
    }


    mapping (address => Packageitem) public Track;
    event Register(address coustmer, Packageitem Data);

    modifier OnlySaller{
        require (Saller == msg.sender, "You are NOt a Saller");
        _;
    }

    function SetCoustomer(address _coustomer) public OnlySaller {
        coustmer = _coustomer;
    }

    function setCustoms(address _custom1,address _custom2) public OnlySaller {
        Custom1 = _custom1;
        Custom2 = _custom2;
    }


    modifier Custom1Only{
        require (msg.sender == address(Custom1),"Custom1 only operation");
        _;
    }

    modifier Custom2Only{
        require (msg.sender == address(Custom2),"Custom2 only operation");
        _;
    }
    

    function setDeliveryHub(address _delivery) public OnlySaller {
        Delivery = _delivery;
    }


    function Tracking() private { 
        Track[coustmer] = Packageitem(
            false,"Ordered Not Confirm",
            "Panding","Panding","Intransit"
            );

        emit Register(msg.sender, Track[coustmer]);
    }


    function ConfirmOrder(address _orderaddress) public OnlySaller{
        Track[_orderaddress].Approve = true;
        require (_orderaddress == coustmer);
        Track[coustmer].orderStatus = "confirm and Send For Custom1 Clearance";

    }

    function ApproveCustom1(address _orderaddress) external Custom1Only{
        require (_orderaddress == coustmer);
        Track[coustmer].Customs1 = "Clear by Custom1 and Approved for Export";
    }


    function ApproveCustom2(address _orderaddress) external Custom2Only{
        require (_orderaddress == coustmer);
        Track[coustmer].Customs2 = "Clear by Custom2 and Approved for Import";
    }

    function DeliveryHub(address _orderaddress) external {
        require (_orderaddress == coustmer);
        Track[coustmer].Delivery = "Recived Package in DeliveryHub";
    }

    function DeliveryDone(address _orderaddress) external {
        require (_orderaddress == coustmer);
        Track[coustmer].Delivery = "Package Delivered";
    }

}
