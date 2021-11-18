@isTest
private class TestUpdateAccountCA {
    @isTest(seeallData = true) static void testCalculateTurnover() {

        List<Account> acc1 = TestDataFactory.createTestAccounts(200, 'test account');
        Product2 pd1 = TestDataFactory.createTestProduct('chemise verte longue', 'Chemise');
        PricebookEntry pbe = TestDataFactory.createTestPriceBookEntry(pd1);
        System.debug('test de taille ' + acc1.size());

        insert acc1;
        System.debug('testAccount Id after Insert : ' + acc1[0].Id);

        //Insertion d'un nouvel ordre
        List<Order> testOrders = new List<Order>();
        List<OrderItem> testOrderItems = new List<OrderItem>();
        for (Account acc : acc1){
        //System.debug('account = ' + acc.Name);
        Order ord = new Order(AccountId = acc.Id, Status = 'Ordered', EffectiveDate=Date.today(), Pricebook2Id = pbe.Pricebook2Id);
        testOrders.add(ord);
        //System.debug('testOrder account = ' + ord.AccountId);
            

        //Insertion de deux produits dans le nouvel ordre
        OrderItem oi1 = new OrderItem (OrderId = ord.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
        testOrderItems.add(oi1);
        OrderItem oi2 = new OrderItem (OrderId = ord.Id, PricebookEntryId = pbe.Id, Quantity=20, UnitPrice = 1000);
        testOrderItems.add(oi2);
            }

        Order ord2 = new Order(AccountId = acc1[0].Id, Status = 'Ordered', EffectiveDate=Date.today(), Pricebook2Id = pbe.Pricebook2Id);
        insert ord2;
        OrderItem oi3 = new OrderItem (OrderId = ord2.Id, PricebookEntryId = pbe.Id, Quantity = 20, UnitPrice = 50);
        insert oi3;
        System.debug('TotalPrice de oi3 : ' + oi3.TotalPrice);

        insert testOrders;
        System.debug('unit price de oi2 : ' + testOrderItems[1].UnitPrice);
        System.debug('Quantity de oi2 : ' + testOrderItems[1].Quantity);
        System.debug('TotalPrice de oi2 : ' + testOrderItems[1].TotalPrice);
        System.debug('testOrders size = ' + testOrders.size());
        System.debug('testOrderItems size = ' + testOrderItems.size());
        

        Test.startTest();

        AccountService.UpdateTurnover(acc1);

        Test.stopTest();

        //On vérifie que le chiffre d'affaire est correctement calculé
        for(Account acc : acc1){
        System.debug(acc1[0].chiffre_d_affaire__c);
        System.assertEquals(acc.chiffre_d_affaire__c, 21500,'Le chiffre d\'affaire mis à jour n\'est pas correct');
        }
    }

    @isTest(seeallData=true) static void testCalculateNetAmount(){

        List<Account> acc1 = TestDataFactory.createTestAccounts(1, 'test account NetAmountCalc');
        Product2 pd1 = TestDataFactory.createTestProduct('chemise verte longue', 'Chemise');
        PricebookEntry pbe = TestDataFactory.createTestPriceBookEntry(pd1);

        insert acc1;

        List<Order> ords = new List<Order>();

        for(Account acc : acc1){
        Order o1 = new Order(AccountId = acc.Id, Status = 'Ordered', EffectiveDate=Date.today(), Pricebook2Id = pbe.Pricebook2Id, ShipmentCost__c = 200);
        ords.add(o1);

        List<OrderItem> listOrds = new List<OrderItem>();
        OrderItem oi1 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 100);
        listOrds.add(oi1);
            }

        insert ords;

        Test.startTest();

        AccountService.calculateNetAmount(ords);

        Test.stopTest();

        for(Order o1 : ords){
        System.assertEquals(o1.NetAmount__c, 800);
        }
    }
}