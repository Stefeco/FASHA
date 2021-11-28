@isTest
private class TestUpdateAccountCA {
    @isTest(seeallData = true) static void testCalculateTurnover() {

        List<Account> acc1 = TestDataFactory.createTestAccounts(1, 'test account');
        List<Order> ord1 = TestDataFactory.createTestOrders(250, 'test order');
        Product2 pd1 = TestDataFactory.createTestProduct('chemise verte longue', 'Chemise');
        PricebookEntry pbe = TestDataFactory.createTestPriceBookEntry(pd1);
        System.debug('test de taille ' + acc1.size());

        insert acc1;
        System.debug('testAccount Id after Insert : ' + acc1[0].Id);

        //Insertion d'un nouvel ordre sur chaque compte
        List<Order> testOrders = new List<Order>();
        List<OrderItem> testOrderItems = new List<OrderItem>();
        for (Account acc : acc1){
            for(Order ord : ord1){
                ord.AccountId = acc.Id;
                ord.Status = 'Ordered';
                ord.EffectiveDate = Date.today();
                ord.Pricebook2Id= pbe.Pricebook2Id;
            }

            //acc1.add(ord1);
        }

        insert ord1;
        System.debug('Order Id après insert = ' + ord1[0].Id);

        //insertion de deux order items dans chaque ordre
        for(Order ord : ord1){
            OrderItem oi1 = new OrderItem (OrderId = ord.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
            testOrderItems.add(oi1);
            OrderItem oi2 = new OrderItem (OrderId = ord.Id, PricebookEntryId = pbe.Id, Quantity=20, UnitPrice = 1000);
            testOrderItems.add(oi2);
        }

        insert testOrderItems;

        System.debug('unit price de oi2 : ' + testOrderItems[0].UnitPrice);
        System.debug('Quantity de oi2 : ' + testOrderItems[0].Quantity);
        System.debug('testOrders size = ' + ord1.size());
        System.debug('testOrderItems size = ' + testOrderItems.size());

        Test.startTest();

        AccountService.UpdateTurnover(acc1);

        Test.stopTest();

        //On vérifie que le chiffre d'affaire est correctement calculé
        for(Account acc : acc1){
        System.debug('chiffre d\'affaire testé : ' + acc.chiffre_d_affaire__c);
        System.debug('21500 * ord1.size() = ' + 21500 * ord1.size());
        System.assertEquals(acc.chiffre_d_affaire__c, 21500 * ord1.size(),'Le chiffre d\'affaire mis à jour n\'est pas correct');
        }
    }
}