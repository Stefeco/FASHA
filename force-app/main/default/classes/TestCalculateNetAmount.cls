@isTest
private class TestCalculateNetAmount {
    
    @isTest(seeAllData=true) static void testCalculateNetAmount(){

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
                ord.NetAmount__c = 0.0;
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

        List<Order> ordSelect = [SELECT Id, TotalAmount, NetAmount__c, ShipmentCost__c FROM Order WHERE Id IN :ord1];
        System.debug('ordSelect = ' + ordSelect);
        System.debug('TotalAmount ordSelect = ' + ordSelect[0].TotalAmount);

        //exécution du test
        Test.startTest();

        for(Order ord : ordSelect){
        ord.Description = 'description de ordre';
        //if(ord.NetAmount__c == null){ord.NetAmount__c = 0.0;}
        }
        System.debug('ordSelect before update = ' + ordSelect);
        system.debug('ordSelect net amount before update = ' + ordSelect[0].netAmount__c);
        System.debug('ordSelect TotalAmount before update = ' + ordSelect[0].TotalAmount);
        update ordSelect;

        Test.stopTest();

        List<Order> testOrder = OrderService.CalculateNetAmount(ordSelect);

        System.assertEquals(testOrder[0].NetAmount__c, 800);
        
    }
}

