Global with sharing class AccountService {
    public static void UpdateChiffreAffaire(List<Account> accts) {

        set<Id> setAccountIds = new set<Id>();

        //on boucle sur tous les comptes et on crée un set avec l'Id
        for(Account a : accts){
            setAccountIds.add(a.Id);
        }

        // on sélection dans un aggrégat la somme de tous les ordres de chaque compte et on les regroupe par AccountId
        AggregateResult[] totalCA = [SELECT AccountId, SUM(TotalAmount) sum FROM Order WHERE 
             AccountId IN :setAccountIds and status='Ordered' GROUP BY AccountId];

        

        //vérification si le chiffre d'affaire n'est pas nul
        if(totalCA != null && totalCA.size()>0){
        for(Account a : accts){

            //on va chercher la somme du chiffre d'affaire dans l'aggrégat totalCA
            Decimal amount = (Decimal)totalCA[0].get('sum');
            //Initialisation à 0 du chiffre d'affaire d'origine dans salesforce
            a.Chiffre_d_affaire__c = (a.Chiffre_d_affaire__c!=null)?a.Chiffre_d_affaire__c:0;

            //la somme des ordres par compte "amount" est ajoutée au chiffre d'affaire.
            a.chiffre_d_affaire__c = a.chiffre_d_affaire__c + amount;

            }
        }
    }
}
