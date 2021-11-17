@isTest
public with sharing class TestUpdateAllAccounts_Batch {
    public TestUpdateAllAccounts_Batch() {

        UpdateAllAccounts_Batch updateAccount = new UpdateAllAccounts_Batch();//Must normally update the turnover of all our acc
        Database.QueryLocator ql = updateAccount.start(null);
        updateAccount.execute(null, lAcc);//lAcc = liste des comptes créés par la factory
        updateAccount.finish(null);

    }
}

/*

*/
