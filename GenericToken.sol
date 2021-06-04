// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.0;

import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/GSN/Context.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/EnumerableSet.sol";


interface IUniswapV2Factory {
    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint256
    );

    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB)
        external
        view
        returns (address pair);

    function allPairs(uint256) external view returns (address pair);

    function allPairsLength() external view returns (uint256);

    function createPair(address tokenA, address tokenB)
        external
        returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;
}

interface IUniswapV2Pair {
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    event Transfer(address indexed from, address indexed to, uint256 value);

    function name() external pure returns (string memory);

    function symbol() external pure returns (string memory);

    function decimals() external pure returns (uint8);

    function totalSupply() external view returns (uint256);

    function balanceOf(address owner) external view returns (uint256);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transfer(address to, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);

    function PERMIT_TYPEHASH() external pure returns (bytes32);

    function nonces(address owner) external view returns (uint256);

    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    event Mint(address indexed sender, uint256 amount0, uint256 amount1);
    event Burn(
        address indexed sender,
        uint256 amount0,
        uint256 amount1,
        address indexed to
    );
    event Swap(
        address indexed sender,
        uint256 amount0In,
        uint256 amount1In,
        uint256 amount0Out,
        uint256 amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint256);

    function factory() external view returns (address);

    function token0() external view returns (address);

    function token1() external view returns (address);

    function getReserves()
        external
        view
        returns (
            uint112 reserve0,
            uint112 reserve1,
            uint32 blockTimestampLast
        );

    function price0CumulativeLast() external view returns (uint256);

    function price1CumulativeLast() external view returns (uint256);

    function kLast() external view returns (uint256);

    function mint(address to) external returns (uint256 liquidity);

    function burn(address to)
        external
        returns (uint256 amount0, uint256 amount1);

    function swap(
        uint256 amount0Out,
        uint256 amount1Out,
        address to,
        bytes calldata data
    ) external;

    function skim(address to) external;

    function sync() external;

    function initialize(address, address) external;
}

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

// pragma solidity >=0.6.2;

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

contract Token is Context, IERC20, Ownable {
    using SafeMath for uint256;
    using Address for address;
    using EnumerableSet for EnumerableSet.AddressSet;

    mapping(address => mapping(address => uint256)) private _allowances;
    mapping(address => uint256) private _balances;

    EnumerableSet.AddressSet private _eligibleTokenholders;
    EnumerableSet.AddressSet private _rangeholders;
    uint256 private constant _minRequiredTokenHolding = 50;
    uint256 private constant _maxRequiredTokenHolding = 10000;
    uint256 public requiredTokenholding;

    address public dailyAddress;
    address public hourlyAddress;

    string private _name = "Generic Token";
    string private _symbol = "TOKEN";
    uint8 private _decimals = 18;
    uint256 private _totalSupply = 100000e18;

    uint16 public TAX_FRACTION = 40;
    uint16 public LP_FRACTION = 40;
    uint16 public BURN_FRACTION = 40;
    address public taxReceiveAddress;

    bool public isTaxEnabled;
    mapping(address => bool) public nonTaxedAddresses;

    IUniswapV2Router02 public uniswapV2Router;
    address public uniswapV2Pair;

    event SwapAndLiquify(
        uint256 tokensSwapped,
        uint256 ethReceived,
        uint256 tokensIntoLiqudity
    );

    constructor(uint256 amount) public {
        require(
            (amount >= _minRequiredTokenHolding) &&
                (amount <= _maxRequiredTokenHolding),
            "Amount out of bounds"
        );
        requiredTokenholding = amount;
        isTaxEnabled = true;
        taxReceiveAddress = msg.sender;
        _balances[msg.sender] = _balances[msg.sender].add(_totalSupply);
        emit Transfer(address(0), msg.sender, _totalSupply);

        // Initialize route to pancakeswap
        IUniswapV2Router02 _uniswapV2Router =
            IUniswapV2Router02(0xD99D1c33F9fC3444f8101754aBC46c52416550D1);

        uniswapV2Pair = IUniswapV2Factory(_uniswapV2Router.factory())
            .createPair(address(this), _uniswapV2Router.WETH());

        // set the rest of the contract variables
        uniswapV2Router = _uniswapV2Router;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function eligibleTokenholderAtIndex(uint256 index)
        public
        view
        returns (address)
    {
        return _eligibleTokenholders.at(index);
    }

    function eligibleTokenholdersSize() public view returns (uint256) {
        return _eligibleTokenholders.length();
    }

    function allowance(address owner, address spender)
        public
        view
        override
        returns (uint256)
    {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount)
        public
        override
        returns (bool)
    {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(
            sender,
            _msgSender(),
            _allowances[sender][_msgSender()].sub(
                amount,
                "ERC20: transfer amount exceeds allowance"
            )
        );
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue)
        public
        virtual
        returns (bool)
    {
        _approve(
            _msgSender(),
            spender,
            _allowances[_msgSender()][spender].add(addedValue)
        );
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue)
        public
        virtual
        returns (bool)
    {
        _approve(
            _msgSender(),
            spender,
            _allowances[_msgSender()][spender].sub(
                subtractedValue,
                "ERC20: decreased allowance below zero"
            )
        );
        return true;
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) private {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function transfer(address recipient, uint256 amount)
        public
        override
        returns (bool)
    {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    // 100 divided by TAX_FRACTION is percentage
    function setTaxFraction(uint16 _TAX_FRACTION) external onlyOwner {
        TAX_FRACTION = _TAX_FRACTION;
    }

    // 100 divided by BURN_FRACTION is percentage
    function setBurnFraction(uint16 _TAX_FRACTION) external onlyOwner {
        require (_TAX_FRACTION >= 10, "Tax can't be higher than 10%");
        require (_TAX_FRACTION <= 100, "Tax can't be lower than 1%");
        BURN_FRACTION = _TAX_FRACTION;
    }

    // 100 divided by LP_FRACTION is percentage
    function setLpFraction(uint16 _TAX_FRACTION) external onlyOwner {
        require (_TAX_FRACTION >= 10, "Tax can't be higher than 10%");
        require (_TAX_FRACTION <= 100, "Tax can't be lower than 1%");
        LP_FRACTION = _TAX_FRACTION;
    }

    function setHourlyAddress(address contractAddress) external onlyOwner {
        if (_eligibleTokenholders.contains(contractAddress)) {
            _eligibleTokenholders.remove(contractAddress);
        }
        if (_rangeholders.contains(contractAddress)) {
            _rangeholders.remove(contractAddress);
        }
        hourlyAddress = contractAddress;
    }

    function setDailyAddress(address contractAddress) external onlyOwner {
        if (_eligibleTokenholders.contains(contractAddress)) {
            _eligibleTokenholders.remove(contractAddress);
        }
        if (_rangeholders.contains(contractAddress)) {
            _rangeholders.remove(contractAddress);
        }
        dailyAddress = contractAddress;
    }

    function _rangeholdersChecker(address person) private {
        if (person == address(this) || person == owner() || person == dailyAddress || person == hourlyAddress) return;
        if (
            _balances[person] >= _minRequiredTokenHolding &&
            _balances[person] <= _maxRequiredTokenHolding
        ) {
            if (!_rangeholders.contains(person)) {
                _rangeholders.add(person);
            }
        } else {
            if (_rangeholders.contains(person)) {
                _rangeholders.remove(person);
            }
        }
    }

    function setRequiredTokenholding(uint256 amount) public onlyOwner {
        require(
            (amount >= _minRequiredTokenHolding) &&
                (amount <= _maxRequiredTokenHolding),
            "Amount out of bounds"
        );
        if (amount != _minRequiredTokenHolding) {
            for (uint256 i = 0; i < _rangeholders.length(); i++) {
                address rangeholder = _rangeholders.at(i);
                if (
                    _balances[rangeholder] >= amount &&
                    !_eligibleTokenholders.contains(rangeholder)
                ) {
                    _eligibleTokenholders.add(rangeholder);
                } else if (
                    _balances[rangeholder] < amount &&
                    _eligibleTokenholders.contains(rangeholder)
                ) {
                    _eligibleTokenholders.remove(rangeholder);
                }
            }
        } else if (amount == _minRequiredTokenHolding) {
            for (uint256 i = 0; i < _rangeholders.length(); i++) {
                if (!_eligibleTokenholders.contains(_rangeholders.at(i))) {
                    _eligibleTokenholders.add(_rangeholders.at(i));
                }
            }
        }
        requiredTokenholding = amount;
    }

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal {
        require(sender != address(0), "Mute: transfer from the zero address");
        require(recipient != address(0), "Mute: transfer to the zero address");

        if (
            nonTaxedAddresses[sender] == true ||
            TAX_FRACTION == 0 ||
            isTaxEnabled == false
        ) {
            _balances[sender] = _balances[sender].sub(
                amount,
                "Mute: transfer amount exceeds balance"
            );
            _balances[recipient] = _balances[recipient].add(amount);

            emit Transfer(sender, recipient, amount);
            return;
        }

        uint256 feeAmount = amount.div(TAX_FRACTION);
        uint256 burnAmount = amount.div(BURN_FRACTION);
        uint256 lpAmount = amount.div(LP_FRACTION);

        uint256 dailyAmount;
        uint256 hourlyAmount;
        if (dailyAddress != address(0)) dailyAmount = amount.div(50);
        if (hourlyAddress != address(0)) hourlyAmount = amount.div(200);

        uint256 newAmount = amount.sub(feeAmount).sub(burnAmount).sub(lpAmount);
        newAmount = newAmount.sub(dailyAmount).sub(hourlyAmount);

        require(
            amount == newAmount.add(feeAmount).add(lpAmount).add(burnAmount).add(dailyAmount).add(hourlyAmount),
            "Mute: math is broken"
        );

        _balances[sender] = _balances[sender].sub(
            amount,
            "Mute: transfer amount exceeds balance"
        );

        _balances[recipient] = _balances[recipient].add(newAmount);

        _balances[taxReceiveAddress] = _balances[taxReceiveAddress].add(
            feeAmount
        );
        _balances[address(0)] = _balances[address(0)].add(burnAmount);
        _balances[address(this)] = _balances[address(this)].add(lpAmount);

        if (dailyAddress != address(0)) _balances[dailyAddress] = _balances[dailyAddress].add(dailyAmount);
        if (hourlyAddress != address(0)) _balances[hourlyAddress] = _balances[hourlyAddress].add(hourlyAmount);

        _rangeholdersChecker(sender);
        _rangeholdersChecker(recipient);

        if (_balances[sender] < requiredTokenholding) {
            if (_eligibleTokenholders.contains(sender)) {
                _eligibleTokenholders.remove(sender);
            }
        }
        if (_balances[recipient] >= requiredTokenholding) {
            if ((!_eligibleTokenholders.contains(recipient)) && (recipient != address(this)) && (recipient != owner()) && (recipient != dailyAddress) && (recipient != hourlyAddress)) {
                _eligibleTokenholders.add(recipient);
            }
        }

        emit Transfer(sender, recipient, newAmount);
        emit Transfer(sender, taxReceiveAddress, feeAmount);
        emit Transfer(sender, address(0), burnAmount);
        emit Transfer(sender, address(this), lpAmount);
    }

    function lotteryTransfer(address winner) external {
        require(msg.sender == dailyAddress || msg.sender == hourlyAddress, "Can only be called by lottery contract");
        uint256 winnings = _balances[msg.sender];
        _balances[msg.sender] = 0;
        _balances[winner] = _balances[winner].add(winnings);
        emit Transfer(msg.sender, winner, winnings);
    }

    function swapTokensForBnb(uint256 tokenAmount) private {
        // generate the uniswap pair path of token -> weth
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = uniswapV2Router.WETH();

        _approve(address(this), address(uniswapV2Router), tokenAmount);

        // make the swap
        uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0, // accept any amount of ETH
            path,
            address(this),
            block.timestamp
        );
    }

    function addLiquidity(uint256 tokenAmount, uint256 ethAmount) internal {
        // approve token transfer to cover all possible scenarios
        _approve(address(this), address(uniswapV2Router), tokenAmount.mul(2));

        // add the liquidity
        uniswapV2Router.addLiquidityETH{value: ethAmount}(
            address(this),
            tokenAmount,
            0, // slippage is unavoidable
            0, // slippage is unavoidable
            owner(),
            block.timestamp
        );
    }

    function swapAndLiquify() external onlyOwner {
        // split the contract balance into halves
        uint256 contractTokenBalance = balanceOf(address(this));
        uint256 half = contractTokenBalance.div(2);
        uint256 otherHalf = contractTokenBalance.sub(half);

        // capture the contract's current BNB balance.
        // this is so that we can capture exactly the amount of BNB that the
        // swap creates, and not make the liquidity event include any BNB that
        // has been manually sent to the contract
        uint256 initialBalance = address(this).balance;

        // swap tokens for ETH
        swapTokensForBnb(half); // <- this breaks the ETH -> HATE swap when swap+liquify is triggered

        // how much ETH did we just swap into?
        uint256 newBalance = address(this).balance.sub(initialBalance);

        // add liquidity to uniswap
        addLiquidity(otherHalf, newBalance);

        emit SwapAndLiquify(half, newBalance, otherHalf);
    }

    function setTaxReceiveAddress(address _taxReceiveAddress)
        external
        onlyOwner
    {
        taxReceiveAddress = _taxReceiveAddress;
    }
}
