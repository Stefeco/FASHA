@isTest
private class TestUpdateAllAccounts_Batch {
    
    @isTest(seeallData = true) static void TestUpdateAllAccounts_Batch() {

        Test.startTest();

        UpdateAllAccounts_Batch updateAccount = new UpdateAllAccounts_Batch();//crée une instance du batch de mise à jour

        Database.executeBatch(updateAccount);

        Test.stopTest();

        //assertion
        List<Account> lAcc = [SELECT Id FROM Account WHERE Id IN (SELECT accountId from order where status='Ordered')];
        for(Account acc : lAcc){
            System.assertEquals(acc.chiffre_d_affaire__c, 21500,'Le chiffre d\'affaire mis à jour n\'est pas correct');
        }

    }
}

/*

*/
