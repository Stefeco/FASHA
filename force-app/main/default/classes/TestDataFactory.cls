@isTest
public with sharing class TestDataFactory {
    
    public static List<Account> createTestAccounts(Integer acctsNum, String name) {

        List<Account> accts = new List<Account>();

        for(integer i=0; i<acctsNum; i++){
        Account acc1 = new Account(name = name + ' ' + i);
        accts.add(acc1);
        }
        //insert accts;
        return accts;
    }

    public static Product2 createTestProduct(String name, String family){

        Product2 pd1 = new Product2(name = name, family = family);
        insert pd1;
        return pd1;
    }


    public static PricebookEntry createTestPriceBookEntry(Product2 pd1){
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = pd1.Id,
            UnitPrice = 1020,
            IsActive = true
            );
        insert pbe;
        return pbe;
    }

    public static List<Order> createTestOrders(Integer ordNum, String name){

        List<Order> ord = new List<Order>();

        for(Integer i=0; i<ordNum ; i++){
            Order ord1 = new Order(name = name + ' ' + i);
            ord.add(ord1);
        }
        return ord;
    }

}
