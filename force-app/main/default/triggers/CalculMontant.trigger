trigger CalculMontant on Order (before update) {

	//création d'un set vide contenant les noms de comptes et id
	Set<Id> setOrderIds = new Set<Id>();

	//trigger.new.size() retourne la taille des sObjects dans la liste qui ont été modifiés
    //création d'un nouvel ordre et calcul du montant net
    for(integer i=0; i< trigger.new.size(); i++){
        Order newOrder= trigger.new[i];
		setOrderIds.add(newOrder.AccountId);
    }

	List<Order> ord = [SELECT Id, TotalAmount, shipmentCost__c FROM Order WHERE Id IN :setOrderIds];
	AccountService.CalculateNetAmount(ord);
}



//newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.shipmentCost__c;
