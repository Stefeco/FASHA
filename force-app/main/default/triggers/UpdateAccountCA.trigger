trigger UpdateAccountCA on Order (after update) {
	
    //création d'un set vide contenant les nom de comptes et leur id
    set<Id> setAccountIds = new set<Id>();
    
    //trigger.new.size() retourne la taille des sObjects dans la liste qui ont été modifiés
    //ensuite ajoute l'id du compte modifié par le trigger.new
    for(integer i=0; i< trigger.new.size(); i++){
        Order newOrder= trigger.new[i];
        setAccountIds.add(newOrder.AccountId);
    }

    List<Account> accts = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN:setAccountIds];
    System.debug('List Account accts size = ' + accts.size());
    //on remplace le calcul en dur en appelant la méthode de service
    AccountService.UpdateTurnover(accts);
}