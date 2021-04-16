const Store = artifacts.require("Store.sol");

contract("Store", async accounts => {
	describe("when creating store", async() => {
		it("should manage points", async () => {
			const instance = await Store.deployed();
			assert.equal( (await instance.getPoints.call()).toNumber(), 0, "Wrong number of points");

			const buyer = "0x541035d3d8Df867a1736509A6909e9E54F0Ad8F0";
			const price = await instance.price.call();
			const receipt = await instance.buy({ from: buyer, value: price*3 });

			assert.equal( (await instance.getPoints.call()).toNumber(), 3, "Wrong number of points");
		})
		it("should sell products", async () => {
			const instance = await Store.deployed();

			const buyer1 = "0x8892de86313f8B454f71c5d4a72d24d40BF3C8C2";
			const buyer2 = "0x81b7BDE6789e7E5F6D2BcD31E709d46779905F6e";

			const price = await instance.price.call();
			const stock = (await instance.stock.call()).toNumber();

			await instance.buy({ from: buyer1, value: price });
			await instance.buy({ from: buyer2, value: price*2 });

			const points1 = await instance.getBalance(buyer1);
			const points2 = await instance.getBalance(buyer2);

			assert.equal(points1, 1, "Account should have 1 point");
			assert.equal(points2, 2, "Account should have 2 points");

			assert.equal( (await instance.stock.call()).toNumber(), stock-3, "Final stock is invalid")
		})
		it("should return change to buyer", async () => {
			const instance = await Store.deployed();

			const buyer = "0xdc4B4a093e3668A54eF2E64F7D3eCFd894D16D23";
			const price = await instance.price.call();

			const receipt = await instance.buy({ from: buyer, value: price*1.5 });

			const change = receipt.logs[0].args._change.toNumber();

			assert.equal( receipt.logs[0].event, "ChangeReceipt", "Event should be triggered");
			assert.equal( change, price/2, "Change is not correct");

		})
	})
})