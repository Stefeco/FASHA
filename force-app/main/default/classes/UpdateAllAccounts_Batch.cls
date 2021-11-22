global class UpdateAllAccounts_Batch implements Database.Batchable<sObject>{
    
        global Database.QueryLocator start(Database.BatchableContext BC){ 
        //on crée une requête qui sélectionne les comptes dont les ordres sont sous statut "ordered"
        return Database.getQueryLocator('SELECT Id FROM Account WHERE Id IN (SELECT accountId from order where status=\'Ordered\')');
        }
         
        global void execute(Database.BatchableContext BC, List<Account> scope){
            //appel de la méthode UpdateChiffreAffaire de la classe service AccountService en passant la liste des comptes sélectionnés en argument
            AccountService.UpdateTurnover(scope);   
    
        }    
         
        global void finish(Database.BatchableContext BC){     
        } 
    
}
