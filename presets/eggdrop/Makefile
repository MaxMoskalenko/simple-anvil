PRIVATE_KEY ?= 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
RPC_URL ?= http://localhost:8545
CHAIN_ID ?= 31337

TOKEN_NAME ?= Test Token
TOKEN_SYMBOL ?= TST
TOKEN_DECIMALS ?= 18
DEPLOYER_INDEX ?= 77358
MNEMONIC ?= test test test test test test test test test test test junk
SCRIPTS_PATH ?= ../../scripts

localnet:
	@echo "Starting local Anvil chain..."
	anvil --chain-id $(CHAIN_ID) --accounts 15 --balance 300

deploy-erc20: 
	@echo "Deploying ERC20 token with parameters:"
	@echo "  Name: $(TOKEN_NAME)"
	@echo "  Symbol: $(TOKEN_SYMBOL)"
	@echo "  Decimals: $(TOKEN_DECIMALS)"
	@forge script $(SCRIPTS_PATH)/DeployAndFundERC20.s.sol \
		--broadcast \
		--rpc-url $(RPC_URL) \
		--sig "run(uint32,string,string,uint8,string)" \
		$(DEPLOYER_INDEX) \
		'"$(TOKEN_NAME)"' \
		'"$(TOKEN_SYMBOL)"' \
		$(TOKEN_DECIMALS) \
		'"$(MNEMONIC)"'

# 0xCE7449f07e32263556ac12cD9DBC1f8bDdFFb28d
deploy-yellow-mock:
	@make deploy-erc20 \
		DEPLOYER_INDEX=77359 \
		TOKEN_NAME="Yellow Token" \
		TOKEN_SYMBOL="YELLOW" \
		TOKEN_DECIMALS=8

# 0x730dB3A1D3Ca47e7BaEb260c24C74ED4378726Bc
deploy-eggdrop-claim:
	@forge script $(SCRIPTS_PATH)/DeployEggDropClaim.s.sol \
		--broadcast \
		--rpc-url $(RPC_URL) \
		--sig "run(uint32,address,bytes32,string)" \
		53231 \
		0xCE7449f07e32263556ac12cD9DBC1f8bDdFFb28d \
		0xe1f9745ffd2df4e15a3ef7054d16e8d5493afcd6b86fe93b46358428fdb3c238 \
		'"$(MNEMONIC)"'

deploy-all: deploy-yellow-mock deploy-eggdrop-claim