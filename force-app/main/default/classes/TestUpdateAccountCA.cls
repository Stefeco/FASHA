@isTest
private class TestUpdateAccountCA {
    @isTest(seeallData = true) static void testCalculateTurnover() {

        Account acc1 = TestDataFactory.createTestAccount('test account 1');
        Product2 pd1 = TestDataFactory.createTestProduct('chemise verte longue', 'Chemise');
        PricebookEntry pbe = TestDataFactory.createTestPriceBookEntry(pd1);

        //Insertion d'un nouvel ordre
        Order o1 = new Order(AccountId = acc1.Id, Status = 'Ordered', EffectiveDate=Date.today(), Pricebook2Id = pbe.Pricebook2Id);
        insert o1;

        //Insertion de deux produits dans le nouvel ordre
        OrderItem oi1 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
        insert oi1;
        OrderItem oi2 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=20, UnitPrice = 1000);
        insert oi2; 
        
        Test.startTest();

        //on crée une liste de comptes et ajoute le compte acc1
        List<Account> accts = new List<Account>();
        accts.add(acc1);
        //appel de la méthode de service
        AccountService.UpdateTurnover(accts);

        Test.stopTest();

        //On vérifie que le chiffre d'affaire est correctement calculé
        System.assertEquals(acc1.chiffre_d_affaire__c, 21500,'Le chiffre d\'affaire mis à jour n\'est pas correct');
    }

    @isTest(seeallData=true) static void testCalculateNetAmount(){

        Account acc1 = TestDataFactory.createTestAccount('test account NetAmountCalc');
        Product2 pd1 = TestDataFactory.createTestProduct('chemise verte longue', 'Chemise');
        PricebookEntry pbe = TestDataFactory.createTestPriceBookEntry(pd1);

        Order o1 = new Order(AccountId = acc1.Id, Status = 'Ordered', EffectiveDate=Date.today(), Pricebook2Id = pbe.Pricebook2Id, ShipmentCost__c = 200);
        insert o1;

        OrderItem oi1 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 100);
        insert oi1;

        Test.startTest();

        List<Order> ords = new List<Order>();
        ords.add(o1);

        AccountService.calculateNetAmount(ords);

        Test.stopTest();

        System.assertEquals(o1.NetAmount__c, 800);
    }
}