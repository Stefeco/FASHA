@isTest
public with sharing class TestDataFactory {
    
    public static Account createTestAccount(String name) {

        Account acc1 = new Account(name = name);
        insert acc1;
        return acc1;
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

    public static Order createTestOrder(OrderId ordId, PricebookEntryId pbId, decimal quantity, decimal unitPrice){

        OrderId ordId = ordId;


        /*
        OrderItem oi1 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
        insert oi1;
        OrderItem oi2 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=20, UnitPrice = 1000);
        insert oi2;
        */ 

    }
}
