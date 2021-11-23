@isTest
private class TestCalculateNetAmount {
    
    @isTest(seeallData=true) static void testCalculateNetAmount(){


        //création des entrées pour le test
        List<Account> acc1 = TestDataFactory.createTestAccounts(1, 'test account NetAmountCalc');
        Product2 pd1 = TestDataFactory.createTestProduct('chemise verte longue', 'Chemise');
        PricebookEntry pbe = TestDataFactory.createTestPriceBookEntry(pd1);

        insert acc1;

        List<Order> ords = new List<Order>();
        
            Order o1 = new Order(AccountId = acc1[0].Id, Status = 'Ordered', EffectiveDate=Date.today(), Pricebook2Id = pbe.Pricebook2Id, ShipmentCost__c = 200);
            ords.add(o1);

        insert ords;

        List<OrderItem> listOrdItems = new List<OrderItem>();

        OrderItem oi1 = new OrderItem (OrderId = ords[0].Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 100);
        listOrdItems.add(oi1);

        insert listOrdItems;

        //exécution du test
        Test.startTest();

        ords[0].Description = 'description de ordre';
        update ords[0];
        Order order = [SELECT Id, netAmount__c FROM Order LIMIT 1];
        System.debug('order net amount = ' + order.netAmount__c);

        Test.stopTest();

        //vérification des résultats
        System.assertEquals(order.NetAmount__c, 800);

    }

}

