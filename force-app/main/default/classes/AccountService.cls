Global with sharing class AccountService {
    public static void UpdateChiffreAffaire(List<Account> accts) {

        set<Id> setAccountIds = new set<Id>();

        for(Account a : accts){
            setAccountIds.add(a.Id);
        }

        AggregateResult[] totalCA = [SELECT AccountId, SUM(TotalAmount) sum FROM Order WHERE 
             AccountId IN :setAccountIds and status='Ordered' GROUP BY AccountId];

        Decimal amount = (Decimal)totalCA[0].get('sum');

        if(totalCA != null && totalCA.size()>0){
        for(Account a : accts){
            a.chiffre_d_affaire__c = a.chiffre_d_affaire__c + amount;
            }
        }
    }
}
