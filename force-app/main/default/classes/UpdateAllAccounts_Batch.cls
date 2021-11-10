global class UpdateAllAccounts_Batch implements Database.Batchable<sObject>{
    
        global Database.QueryLocator start(Database.BatchableContext info){ 
        //on crée une requête qui sélectionne les comptes dont les ordres sont sous statut "ordered"
        return Database.getQueryLocator('SELECT Id FROM Account WHERE Id IN (SELECT accountid from order where status=\'Ordered\')');
        }
         
        global void execute(Database.BatchableContext info, List<Account> scope){
            //appel de la méthode UpdateChiffreAffaire de la classe service AccountService en passant la liste des comptes sélectionnés en argument
            AccountService.UpdateTurnover(scope);   
    
        }    
         
        global void finish(Database.BatchableContext info){     
        } 
    
}
