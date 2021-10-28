@isTest
private class TestUpdateAccountCA {
    @isTest(seeallData = true) static void test() {

        //Création du compte
        Account acc1 = new Account(Name = 'Test Account 1');
        insert acc1;

        //Création du produit
        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        insert pd1;
 
        //Creation du PricebookEntry
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = pd1.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        Insert pbe;

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
        AccountService.UpdateChiffreAffaire(accts);

        Test.stopTest();

        //On vérifie que le chiffre d'affaire est correctement calculé
        System.assertEquals(acc1.chiffre_d_affaire__c, 21500);
    }

}