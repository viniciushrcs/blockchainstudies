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
	})
})