// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;
pragma abicoder v2;

// File: @openzeppelin/contracts/token/ERC20/IWETH.sol
/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */

interface IWETH {
    function deposit() external payable;

    function withdraw(uint256 value) external;

    function transfer(address to, uint256 value) external returns (bool);

    function approve(address spender, uint256 value) external returns (bool);

    function balanceOf(address owner) external view returns (uint256);
    
}

// File: @uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router01.sol

interface IUniswapV2Router01 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    )
        external
        returns (
            uint256 amountA,
            uint256 amountB,
            uint256 liquidity
        );

    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    )
        external
        payable
        returns (
            uint256 amountToken,
            uint256 amountETH,
            uint256 liquidity
        );

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETH(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountToken, uint256 amountETH);

    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETHWithPermit(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountToken, uint256 amountETH);

    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapTokensForExactTokens(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactETHForTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function swapTokensForExactETH(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactTokensForETH(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapETHForExactTokens(
        uint256 amountOut,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function quote(
        uint256 amountA,
        uint256 reserveA,
        uint256 reserveB
    ) external pure returns (uint256 amountB);

    function getAmountOut(
        uint256 amountIn,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountOut);

    function getAmountIn(
        uint256 amountOut,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountIn);

    function getAmountsOut(uint256 amountIn, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);

    function getAmountsIn(uint256 amountOut, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);
}

// File: @uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountETH);

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
}

interface ISwapRouter {
    function multicall(uint256 deadline, bytes[] calldata data)
        external
        payable
        returns (bytes[] calldata);

    function WETH9() external pure returns (address);
}

interface IChild {
    function swapToken(
        address[] memory path,
        uint256 percent,
        bool flag
    ) external;

    function withdrawToken(
        address to,
        address token
    ) external;

    function unLock() external;
}


abstract contract Context {
	function _msgSender() internal view virtual returns (address) {
			return msg.sender;
	}
}

abstract contract Ownable is Context {
	address private _owner;

	event OwnershipTransferred(
			address indexed previousOwner,
			address indexed newOwner
	);

	/**
		* @dev Initializes the contract setting the deployer as the initial owner.
		*/
	constructor() {
			_setOwner(_msgSender());
	}

	/**
		* @dev Returns the address of the current owner.
		*/
	function owner() public view virtual returns (address) {
			return _owner;
	}

	/**
		* @dev Throws if called by any account other than the owner.
		*/
	modifier onlyOwner() {
			require(owner() == _msgSender(), "Ownable: caller is not the owner");
			_;
	}

	/**
		* @dev Leaves the contract without owner. It will not be possible to call
		* `onlyOwner` functions anymore. Can only be called by the current owner.
		*
		* NOTE: Renouncing ownership will leave the contract without an owner,
		* thereby removing any functionality that is only available to the owner.
		*/
	function renounceOwnership() public virtual onlyOwner {
			_setOwner(address(0));
	}

	/**
		* @dev Transfers ownership of the contract to a new account (`newOwner`).
		* Can only be called by the current owner.
		*/
	function transferOwnership(address newOwner) public virtual onlyOwner {
			require(
					newOwner != address(0),
					"Ownable: new owner is the zero address"
			);
			_setOwner(newOwner);
	}

	function _setOwner(address newOwner) private {
			address oldOwner = _owner;
			_owner = newOwner;
			emit OwnershipTransferred(oldOwner, newOwner);
	}
}

contract Child is Ownable {
    ISwapRouter public swapRouter;

    address public weth;

    mapping(address => bool) private whitelist;
    mapping(address => bool) public isLock;
    bytes12 constant zero = bytes12(0x000000000000000000000000);
    bytes4 private constant buyMethodId = 0x42712a67;
    bytes4 private constant sellMethodId = 0x472b43f3;
    bytes4 private constant unwrapWETHId = 0x49404b7c;
    uint256 public constant poolFee = 128;
    uint256 public constant pathLen0 = 2;
    uint256 public constant pathLen1 = 3;
    uint256 public constant amountOutMinimum = 100;
    uint256 public constant MAX_VALUE = 2**256 - 1;

    constructor() {
        swapRouter = ISwapRouter(0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45);
        weth = swapRouter.WETH9();
        IWETH(weth).approve(
            0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45,
            MAX_VALUE
        );
    }

    modifier isWhitelist() {
        require(whitelist[msg.sender] == true, "Caller is not Parent Contract");
        _;
    }

    function setWhitelist(address _newAddr) 
        external 
        onlyOwner 
    {
        whitelist[_newAddr] = true;
    }

    function remoteWhitelist(address _address) 
        external 
        onlyOwner 
    {
        whitelist[_address] = false;
    }

    function unLock(address token) 
        external 
        isWhitelist 
    {
        isLock[token] = true;
    }

    function swapToken(
        address[] memory path,
        uint256 percent,
        bool flag
    ) 
        external 
        isWhitelist 
    {
        if(flag) 
            require(isLock[path[1]], "Unlock!");
        require(path.length < 3, "Exceed path");

        (bytes memory _data, address _tokenIn, uint256 _amountIn) = getParams(
            path,
            percent,
            flag
        );
        if (_amountIn > 0) {
            if (!flag) IWETH(_tokenIn).approve(address(swapRouter), _amountIn);
            bytes[] memory data = new bytes[](1);
            uint256 deadline = block.timestamp + 1000;
            data[0] = _data;

            bytes[] memory result = swapRouter.multicall(deadline, data);
            if (result[0].length > 0 && flag) 
                isLock[path[1]] = false;
        }
    }

    function deposit() 
        external 
        onlyOwner 
    {
        require(address(this).balance > 0, "No Eth Balance");
        IWETH(weth).deposit{value: address(this).balance}();
    }

    function withdrawEth() 
        external 
        onlyOwner 
    {
        if (IWETH(weth).balanceOf(address(this)) > 0) {
            IWETH(weth).withdraw(IWETH(weth).balanceOf(address(this)));
        }

        require(address(this).balance > 0, "Insufficient balance");
        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        require(sent);
    }

    function withdrawToken(address _to, address _token) 
        external 
        onlyOwner 
    {
        require(IWETH(_token).balanceOf(address(this)) > 0);
        IWETH(_token).transfer(
            _to,
            IWETH(_token).balanceOf(address(this))
        );
    }

    receive() external payable {}
    fallback() external payable {}

    function getParams(
        address[] memory _path,
        uint256 _percent,
        bool _flag
    )
        internal
        view
        returns (
            bytes memory,
            address,
            uint256
        )
    {
        uint256 len = _path.length + 1;
        address recipient;
        address[] memory newPath = new address[](len);
        if (len == 2) {
            recipient = address(this);
            newPath[0] = weth;
            newPath[1] = _path[0];
        } else {
            if (_flag) {
                recipient = address(this);
                newPath[0] = weth;
                newPath[1] = _path[0];
                newPath[2] = _path[1];
            } else {
                recipient = msg.sender;
                newPath[0] = _path[0];
                newPath[1] = _path[1];
                newPath[2] = weth;
            }
        }

        uint256 amountIn = (IWETH(newPath[0]).balanceOf(address(this)) *
            _percent) / 10**2;

        bytes memory paths;
        bytes[] memory tokens = new bytes[](newPath.length);
        for (uint256 i = 0; i < newPath.length; i++) {
            tokens[i] = bytes.concat(zero, abi.encodePacked(newPath[i]));
            paths = bytes.concat(paths, tokens[i]);
        }
        bytes memory data;

        if (_flag)
            data = bytes.concat(
                buyMethodId,
                bytes32(amountOutMinimum),
                bytes32(amountIn),
                bytes32(poolFee),
                zero,
                abi.encodePacked(recipient),
                bytes32(newPath.length),
                paths
            );
        else {
            data = bytes.concat(
                sellMethodId,
                bytes32(amountIn),
                bytes32(amountOutMinimum),
                bytes32(poolFee),
                zero,
                abi.encodePacked(recipient),
                bytes32(newPath.length),
                paths
            );
        }

        return (data, newPath[0], amountIn);
    }

    function getEthBalance() 
        external 
        view 
        returns (uint256) 
    {
        return address(this).balance;
    }

    function getBalance(address token) 
        external 
        view 
        returns (uint256) 
    {
        return IWETH(token).balanceOf(address(this));
    }
}

contract Parent is Ownable{
    IUniswapV2Router02 public router;

    address[] public children;
    address public weth;
    uint256 public constant percentForBuy = 100;
    mapping(address => bool) whitelist;

    event LogChildCreated(address child);

    modifier isWhitelist() {
        require(whitelist[msg.sender] == true, "Caller is not whitelist");
        _;
    }

    constructor() {
        router = IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
        whitelist[msg.sender] = true;
        weth = router.WETH();
    }

    function addBulckWhitelists(address[] calldata _whitelist) 
        external 
        onlyOwner 
    {
        for (uint256 i = 0; i < _whitelist.length; i++) {
            whitelist[_whitelist[i]] = true;
        }
    }

    function removeWhitelist(address[] calldata _blacklist) 
        external 
        onlyOwner 
    {
        for (uint256 i = 0; i < _blacklist.length; i++) {
            whitelist[_blacklist[i]] = false;
        }
    }

    function multiBuyToken(
        address[] memory path,
        uint256 amountIn,
        uint256 amountPerChild,
        uint256[] calldata idxs
    ) 
        external 
        isWhitelist 
    {
        require(path.length < 3, "Exceed path");
        uint256 tokenBalance = IWETH(weth).balanceOf(address(this));
        require(
            tokenBalance > amountPerChild,
            "Invalid input amount for Child"
        );

        for (uint256 i = 0; i < idxs.length; i++) {
            require(idxs[i] < children.length, "Exceed array index");
        }

        uint256 cnt;
        if (amountIn > tokenBalance) amountIn = tokenBalance;
        cnt = amountIn / amountPerChild;
        if (cnt > idxs.length) cnt = idxs.length;

        for (uint256 i = 0; i < cnt - 1; i++) {
            IWETH(weth).transfer(children[idxs[i]], amountPerChild);
            IChild(children[idxs[i]]).swapToken(path, percentForBuy, true);
            amountIn -= amountPerChild;
        }

        IWETH(weth).transfer(children[idxs[cnt - 1]], amountIn);
        IChild(children[idxs[cnt - 1]]).swapToken(path, percentForBuy, true);
    }

    function multiBuyTokenForExactAmountOut(
        address[] calldata path,
        uint256 amountIn,
        uint256 amountOut,
        uint256[] calldata idxs
    ) 
        external 
        isWhitelist 
    {
        require(path.length < 3, "Exceed path");
        for (uint256 i = 0; i < idxs.length; i++) {
            require(idxs[i] < children.length, "Exceed array index");
        }
        uint256 amountPerChild = _getAmuntsIn(amountOut, path);

        uint256 tokenBalance = IWETH(weth).balanceOf(address(this));
        require(tokenBalance > amountPerChild, "Invalid input amount");

        uint256 cnt;
        if (amountIn > tokenBalance) amountIn = tokenBalance;
        cnt = amountIn / amountPerChild;
        if (cnt > idxs.length) cnt = idxs.length;

        for (uint256 i = 0; i < cnt - 1; i++) {
            IWETH(weth).transfer(children[idxs[i]], amountPerChild);
            IChild(children[idxs[i]]).swapToken(path, percentForBuy, true);
            amountIn -= amountPerChild;
        }

        IWETH(weth).transfer(children[idxs[cnt - 1]], amountIn);
        IChild(children[idxs[cnt - 1]]).swapToken(path, percentForBuy, true);
    }

    function multiSellToken(
        address[] calldata path,
        uint256[] calldata idxs,
        uint256 percent
    ) 
        external 
        isWhitelist 
    {
        require(path.length == 2, "Exceed path");
        for (uint256 i = 0; i < idxs.length; i++) {
            require(idxs[i] < children.length, "Exceed array index");
        }
        for (uint256 i = 0; i < idxs.length; i++) {
            IChild(children[idxs[i]]).swapToken(path, percent, false);
        }
    }

    function deposit() 
        external 
        onlyOwner 
    {
        require(address(this).balance > 0, "No Eth Balance");
        IWETH(weth).deposit{value: address(this).balance}();
    }

    function withdrawEth() 
        external 
        onlyOwner 
    {
        if (IWETH(weth).balanceOf(address(this)) > 0) {
            IWETH(weth).withdraw(IWETH(weth).balanceOf(address(this)));
        }

        require(address(this).balance > 0, "Insufficient balance");
        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        require(sent);
    }

    function withdrawToken(address _address) 
        external 
        onlyOwner 
    {
        require(IWETH(_address).balanceOf(address(this)) > 0);
        IWETH(_address).transfer(
            msg.sender,
            IWETH(_address).balanceOf(address(this))
        );
    }

    function withdrawTokenFromChild(uint256 childID, address _to, address _token)
        external 
        onlyOwner
    {
        address child = children[childID];
        IChild(child).withdrawToken(_to, _token);
    }

    receive() external payable {}

    function unLockChild(uint256[] calldata idxs) 
        public 
        onlyOwner 
    {
        for (uint256 i = 0; i < idxs.length; i++) {
            require(idxs[i] < children.length, "Exceed array index");
        }
        for (uint256 i = 0; i < idxs.length; i++) {
            IChild(children[idxs[i]]).unLock();
        }
    }

    function _getAmuntsIn(uint256 amountOut, address[] calldata path)
        internal
        view
        returns (uint256 amountIn)
    {
        uint256[] memory amounts = router.getAmountsIn(amountOut, path);
        require(amounts[0] > 0, "No liquidity pool");
        amountIn = amounts[0];
    }

    function getEthBalance() 
        external 
        view 
        returns (uint256) 
    {
        return address(this).balance;
    }

    function getTokenBalance(address token) 
        external 
        view 
        returns (uint256) 
    {
        return IWETH(token).balanceOf(address(this));
    }

    function getChildren() 
        external 
        view 
        returns (address[] memory) 
    {
        return children;
    }

    function getChildrenETHBalance(uint256 childID)
        external
        view
        returns (address, uint256)
    {
        address child = children[childID];
        uint256 balance = child.balance;
        return (child, balance);
    }

    function getChildrenTokenBalance(uint256 childID, address token)
        external
        view
        returns (address, uint256)
    {
        address child = children[childID];
        uint256 balance = IWETH(token).balanceOf(child);
        return (child, balance);
    }
}
