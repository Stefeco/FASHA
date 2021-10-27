Global with sharing class AccountService {
    public static void UpdateChiffreAffaire(List<Account> accts) {

        set<Id> setAccountIds = new set<Id>();

        for(Account a : accts){
            setAccountIds.add(a.Id);
        }

        AggregateResult[] totalCA = [SELECT AccountId, SUM(TotalAmount) sum FROM Order WHERE 
             AccountId IN :setAccountIds and status='Ordered' GROUP BY AccountId];

        

        if(totalCA != null && totalCA.size()>0){
        for(Account a : accts){

            Decimal amount = (Decimal)totalCA[0].get('sum');
            a.Chiffre_d_affaire__c = (a.Chiffre_d_affaire__c!=null)?a.Chiffre_d_affaire__c:0;

            a.chiffre_d_affaire__c = a.chiffre_d_affaire__c + amount;

            }
        }
    }
}
