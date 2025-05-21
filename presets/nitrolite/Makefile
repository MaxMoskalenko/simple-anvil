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

deploy-usdc-mock:
	@make deploy-erc20 \
		DEPLOYER_INDEX=77360 \
		TOKEN_NAME="USD Coin" \
		TOKEN_SYMBOL="USDC" \
		TOKEN_DECIMALS=6

deploy-custody:
	@forge script $(SCRIPTS_PATH)/DeployNitroliteCustody.s.sol \
		--broadcast \
		--rpc-url $(RPC_URL) \
		--sig "run(uint32,string)" \
		58808 \
		'"$(MNEMONIC)"'

deploy-dummy-adjudicator:
	@forge script $(SCRIPTS_PATH)/DeployDummyAdjudicator.s.sol \
		--broadcast \
		--rpc-url $(RPC_URL) \
		--sig "run(uint32,string)" \
		35305 \
		'"$(MNEMONIC)"'

deploy-all: deploy-custody deploy-dummy-adjudicator deploy-usdc-mock
