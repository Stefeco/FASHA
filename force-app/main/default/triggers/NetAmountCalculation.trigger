trigger NetAmountCalculation on Order (before update) {
	System.debug('lancement du trigger NetAmountCalculation');

	List<Order> ordUpdated = [SELECT Id, NetAmount__c, TotalAmount, ShipmentCost__c FROM Order
								WHERE Id IN :Trigger.new];

	System.debug('List<Order> ordUpdated dans trigger = ' + ordUpdated);

	OrderService.CalculateNetAmount(ordUpdated);

}


