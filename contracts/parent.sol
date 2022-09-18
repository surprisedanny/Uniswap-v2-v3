// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

interface IChild {
    function swapToken(address tokenIn, address tokenOut) external;
}

interface IERC20 {
    function deposit() external payable;

    function withdraw(uint256 value) external;

    function transfer(address to, uint256 value) external returns (bool);

    function approve(address spender, uint256 value) external returns (bool);

    function balanceOf(address owner) external view returns (uint256);
}

contract Parent {
    address public  owner;
    mapping(address => bool) whitelist;
    address[] public children;

    address public weth;

    modifier isOwner() {
        require(msg.sender == owner, "Caller is not owner");
        _;
    }

    modifier isWhitelist() {
        require(whitelist[msg.sender] == true, "Caller is not whitelist");
        _;
    }

    constructor(address _weth) {
        owner = msg.sender;
        whitelist[msg.sender] = true;
        weth = _weth;
    }

    function setWhitelist(address[] calldata _whitelist) external isOwner {
        for (uint256 i = 0; i < _whitelist.length; i++) {
            whitelist[_whitelist[i]] = true;
        }
    }

    function removeWhitelist(address[] calldata _blacklist) external isOwner {
        for (uint256 i = 0; i < _blacklist.length; i++) {
            whitelist[_blacklist[i]] = false;
        }
    }

    function setOwner(address _owner) external isOwner {
        owner = _owner;
    }

    function setWeth(address _weth) external isOwner {
        weth = _weth;
    }

    function addChildren(address[] calldata _childContracts) external isOwner {
        for (uint256 i = 0; i < _childContracts.length; i++) {
            children.push(_childContracts[i]);
        }
    }

    function multiBuyToken(
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint256[] calldata idxs,
        uint256 amountPerChild
    ) external isWhitelist {
        uint256 tokenBalance = IERC20(tokenIn).balanceOf(address(this));
        require(tokenBalance > amountPerChild, "Invalid input amount");
        
        for (uint256 i = 0; i < idxs.length; i++) {
            require(idxs[i] < children.length, "Exceed array index");
        }

        uint256 cnt;
        if(amountIn > tokenBalance)
            amountIn = tokenBalance;
        cnt = amountIn / amountPerChild;

        for (uint256 i = 0; i < cnt - 1; i++) {
            IERC20(tokenIn).transfer(children[idxs[i]], amountPerChild);
            IChild(children[idxs[i]]).swapToken(tokenIn, tokenOut);
            amountIn -= amountPerChild;
        }
        IERC20(tokenIn).transfer(children[idxs[cnt - 1]], amountIn);
        IChild(children[idxs[cnt - 1]]).swapToken(tokenIn, tokenOut);
    }

    function multiSellToken(address tokenIn, address tokenOut, uint256[] calldata idxs) external isWhitelist {
        for (uint256 i = 0; i < idxs.length; i++) {
            require(idxs[i] < children.length, "Exceed array index");
        }
        for(uint256 i = 0; i < idxs.length; i ++) {
            IChild(children[idxs[i]]).swapToken(tokenIn, tokenOut);
        }
    }

    function deposit() external isOwner {
        require(address(this).balance > 0, "No Eth Balance");
        IERC20(weth).deposit{value: address(this).balance}();
    }

    function withdrawEth() external isOwner {
        if (IERC20(weth).balanceOf(address(this)) > 0) {
            IERC20(weth).withdraw(IERC20(weth).balanceOf(address(this)));
        }

        require(address(this).balance > 0, "Insufficient balance");
        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        require(sent);
    }

    receive() external payable {}
}
