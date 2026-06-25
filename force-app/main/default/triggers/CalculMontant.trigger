/**
 * Trigger : CalculMontant
 * Objet : Order
 * Description : Calcule automatiquement le montant net (NetAmount__c)
 *               en soustrayant les frais d'expédition du montant total.
 * Formule : NetAmount = TotalAmount - ShipmentCost
 */
trigger CalculMontant on Order (before update) {
    
    for (Order order : Trigger.new) {
        if (order.ShipmentCost__c != null) {
            order.NetAmount__c = order.TotalAmount - order.ShipmentCost__c;
        }
    }
}