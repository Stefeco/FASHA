@isTest
private class TestCalculateNetAmount {
    
    @isTest(seeallData=true) static void testCalculateNetAmount(){


        //création des entrées pour le test
        List<Account> acc1 = TestDataFactory.createTestAccounts(1, 'test account NetAmountCalc');
        Product2 pd1 = TestDataFactory.createTestProduct('chemise verte longue', 'Chemise');
        PricebookEntry pbe = TestDataFactory.createTestPriceBookEntry(pd1);

        insert acc1;

        //création d'une liste d'ordres via la datafactory
        List<Order> ord1 = TestDataFactory.createTestOrders(200, 'test order');
        
        for(Account acc : acc1){
            for(Order ord : ord1){
                ord.AccountId = acc.Id;
                ord.Status = 'Ordered';
                ord.EffectiveDate = Date.today();
                ord.Pricebook2Id= pbe.Pricebook2Id;
                ord.ShipmentCost__c = 200;
            }
        }

        insert ord1;

        //création d'une liste d'orderItems
        List<OrderItem> listOrdItems = new List<OrderItem>();

        for(Order ord : ord1){
        OrderItem oi1 = new OrderItem (OrderId = ord.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 100);
        listOrdItems.add(oi1);
        }

        insert listOrdItems;

        //exécution du test
        Test.startTest();

        for(Order ord : ord1){
        ord.Description = 'description de ordre';
        }
        update ord1;
        Order ordSelect = [SELECT Id, netAmount__c FROM Order LIMIT 1];

        Test.stopTest();

        System.assertEquals(ordSelect.NetAmount__c, 800);
    }
}

