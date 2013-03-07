var assert = require("assert")
var FareCalculator = require(__dirname + '/../fareCalculator')

describe("Fare calculator", function(){
	describe("Base charge", function(){
		var calc;
		beforeEach(function(){
		    calc = new FareCalculator();
		});
		it("Should be 5.70€", function(){
			calc.date = new Date("March 4, 2013");
			assert.equal(5.70, calc.getCharge());
		})
		
		it("Should be 8.80€ on saturday", function(){
			calc.date = new Date("March 2, 2013");
			assert.equal(8.80, calc.getCharge());
		})
		
		it("Should be 8.80€ on sunday", function(){
			calc.date = new Date("March 3, 2013");
			assert.equal(8.80, calc.getCharge());
		})
	})
	
	describe("Distance charge", function(){
		var calc;
		beforeEach(function(){
		    calc = new FareCalculator();
			calc.date = new Date("March 4, 2013");
		});
		
		it("should be 1.48/km for under three passengers", function(){
			calc.addDistance(5);
			assert.equal(13.1, calc.getCharge());
		})
		it("should be 1.78/km for over three passengers", function(){			
			calc.passengers=3;
			calc.addDistance(5);
			assert.equal(14.6, calc.getCharge());
		})
		it("should be 1.92/km for over five passengers", function(){
			calc.passengers=5;
			calc.addDistance(5);
			assert.equal(15.3, calc.getCharge());
		})
		it("should be 2.07/km for over seven passengers", function(){
			calc.passengers=7;
			calc.addDistance(5);
			assert.equal(16.05, calc.getCharge());
		})
	})
	
})
