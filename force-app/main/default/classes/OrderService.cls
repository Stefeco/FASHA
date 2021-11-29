Global with sharing class OrderService {


    public static List<Order> CalculateNetAmount(List<Order>ordList) {

        for (Order ord : ordList){
            if(ord.netAmount__c == null){ord.netAmount__c = 0.0;}
    
            ord.NetAmount__c = ord.TotalAmount - ord.ShipmentCost__c;
        }
    
        System.debug('service class ordList.NetAmount = ' + ordList[0].NetAmount__c);

        return ordList;

    }

}
