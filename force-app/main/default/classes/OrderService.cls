Global with sharing class OrderService {
    
    
    public static List<Order> CalculateNetAmount(List<Order> ords) {

        for (Order ord : ords){
            if(ord.netAmount__c == null){ord.netAmount__c = 0.0;}
    
            ord.NetAmount__c = ord.TotalAmount - ord.ShipmentCost__c;
        }
    
        System.debug('trigger class ordList.NetAmount = ' + ords[0].NetAmount__c);

        return ords;

    }
}
