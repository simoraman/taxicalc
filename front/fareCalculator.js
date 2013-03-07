var FareCalculator = function (){
	var self = this;
	self.distance = 0;
	self.date = new Date();
	self.passengers = 1;
	
	self.getBaseCharge = function(){
		if(self.date.getDay() == 6 || self.date.getDay() == 0 ){
			return 8.80;
		}
		return 5.7;
	}
	self.addDistance = function(distance){
		self.distance += distance;
	}
	
	self.getCharge = function(){
		return (self.getBaseCharge() + self.distance * self.getDistanceCharge()).toFixed(2);
	}
	
	self.getDistanceCharge = function(){
		if(self.passengers > 6){
			return 2.07;
		}
		if(self.passengers > 4){
			return 1.92;
		}
		if(self.passengers > 2){
			return 1.78;
		}
		return 1.48;
	}
};

if (typeof require !== 'undefined') {
	module.exports = FareCalculator;
}