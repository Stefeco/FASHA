trigger NetAmountCalculation on Order (before update) {
	System.debug('lancement du trigger');

	List<Order> ordUpdated = [SELECT Id, NetAmount__c, TotalAmount, ShipmentCost__c FROM Order
								WHERE Id IN :trigger.new];

	System.debug('List<Order> ordUpdated = ' + ordUpdated);

	for (Order ord : ordUpdated){
		if(ord.netAmount == null){ord.netAmount = 0.0;}

		ord.NetAmount__c = ord.TotalAmount - ord.ShipmentCost__c;

	}

	update ordUpdated;
	
	System.debug('trigger ord.NetAmount = ' + ordUpdated[0].NetAmount__c);

}


