-include .env

.PHONY: all test clean deploy fund help install snapshot format anvil 

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

help:
	@echo "Usage:"
	@echo "  make deploy [ARGS=...]\n    example: make deploy ARGS=\"--network sepolia\""
	@echo ""
	@echo "  make fund [ARGS=...]\n    example: make deploy ARGS=\"--network sepolia\""

all: clean remove install update build

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install :; forge install cyfrin/foundry-devops@0.0.11 --no-commit && forge install smartcontractkit/chainlink-brownie-contracts@0.6.1 --no-commit && forge install foundry-rs/forge-std@v1.5.3 --no-commit && forge install openzeppelin/openzeppelin-contracts@v4.8.3 --no-commit && forge install erc6551=erc6551/reference --no-commit && forge install api3dao/airnode --no-commit   && forge install gelato=gelatodigital/automate --no-commit

# Update Dependencies
update:; forge update

build:; forge build

test :; forge test 

coverage :; forge coverage --report debug > coverage-report.txt

snapshot :; forge snapshot

format :; forge fmt

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

ifeq ($(findstring --network mumbai,$(ARGS)),--network mumbai)
	NETWORK_ARGS := --rpc-url $(MUMBAI_RPC_URL) --private-key $(DEV_PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(POLYGON_SCAN_API_KEY) --legacy
endif

deployNFTDrop:
	@forge script script/DeployNFTDrop.s.sol:DeployNFTDrop $(NETWORK_ARGS)

setBaseURI:
	@forge script script/Interactions.s.sol:SetBaseURI $(NETWORK_ARGS)

deployQuestNFT:
	@forge script script/DeployQuestNFT.s.sol:DeployQuestNFT $(NETWORK_ARGS)

createQuestNFT: 
	@forge script script/Interactions.s.sol:CreateQuestNFT $(NETWORK_ARGS)

mintQuestCompletionNFT: 
	@forge script script/Interactions.s.sol:MintQuestCompletionNFT $(NETWORK_ARGS)

deployEscrow:
	@forge script script/DeployEscrow.s.sol:DeployEscrow $(NETWORK_ARGS)

stake: 
	@forge script script/Interactions.s.sol:Stake $(NETWORK_ARGS)

distributeRewards:
	@forge script script/Interactions.s.sol:DistributeRewards $(NETWORK_ARGS)

setSponsorWallet:
	@forge script script/Interactions.s.sol:SetSponsorWallet $(NETWORK_ARGS)

mintTaskCompletetionNFT:
	@forge script script/Interactions.s.sol:MintTaskCompletionNFT $(NETWORK_ARGS)

deployMarketplace:
	@forge script script/DeployMarketplace.s.sol:DeployMarketPlace $(NETWORK_ARGS)