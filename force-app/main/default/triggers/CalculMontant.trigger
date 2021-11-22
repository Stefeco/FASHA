trigger CalculMontant on Order (before update) {
	System.debug('lancement du trigger');

	//création d'un set vide contenant les noms de comptes et id
	Set<Id> setOrderIds = new Set<Id>();

	Order newOrder= trigger.new[0];
	newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;
}


