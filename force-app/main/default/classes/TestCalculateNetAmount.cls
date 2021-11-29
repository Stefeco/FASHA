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
        //System.debug('ord1 after insert ' + ord1);OK

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
        }
        System.debug('ordSelect before update = ' + ordSelect);
        system.debug('ordSelect net amount before update = ' + ordSelect[0].netAmount__c);
        System.debug('ordSelect TotalAmount before update = ' + ordSelect[0].TotalAmount);
        update ordSelect;
        System.debug('ordSelect List after update ' + ordSelect);
        System.debug('ordSelect Net Amount after update = ' + ordSelect[0].NetAmount__c);

        Test.stopTest();

        for(Order ord : ordSelect){
        
        //System.assertEquals(ord.NetAmount__c, 800);
        }
        System.debug('ord NetAmount value = ' + ordSelect[0].netAmount__c);

        System.assertEquals(ordSelect[0].TotalAmount, 1000);
        //System.assertEquals(ordSelect[0].NetAmount__c, 800);
    }
}

