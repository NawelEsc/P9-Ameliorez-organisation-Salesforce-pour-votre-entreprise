/**
 * Classe de test : testCalculMontant
 * Description : Teste le trigger CalculMontant.
 * Vérifie que NetAmount = TotalAmount - ShipmentCost.
 */
@isTest
public class testCalculMontant {

    /**
     * Teste que NetAmount est correctement calculé
     * lorsque ShipmentCost est renseigné.
     */
    @isTest
    static void testNetAmountCalculation() {
        // Création des données de test
        Account account = TestDataFactory.createAccount('Test Account CalculMontant');
        Product2 product = TestDataFactory.createProduct('Chemise Test', 'Chemise');
        PricebookEntry pricebookEntry = TestDataFactory.createPricebookEntry(product.Id, 500);
        Order order = TestDataFactory.createOrder(account.Id, 'Draft');
        TestDataFactory.createOrderItem(order.Id, pricebookEntry.Id, 2, 500);

        // Execution du test
        Test.startTest();
        order.ShipmentCost__c = 50;
        update order;
        Test.stopTest();

        // Verification
        Order updatedOrder = [SELECT NetAmount__c, TotalAmount, ShipmentCost__c FROM Order WHERE Id = :order.Id];
        System.assertEquals(
            updatedOrder.TotalAmount - 50, 
            updatedOrder.NetAmount__c, 
            'NetAmount doit etre egal a TotalAmount - ShipmentCost'
        );
    }

    /**
     * Teste que NetAmount n'est pas calculé
     * lorsque ShipmentCost est null.
     */
    @isTest
    static void testNetAmountNullShipment() {
        // Création des données de test
        Account account = TestDataFactory.createAccount('Test Account Null Shipment');
        Product2 product = TestDataFactory.createProduct('Chemise Test 2', 'Chemise');
        PricebookEntry pricebookEntry = TestDataFactory.createPricebookEntry(product.Id, 500);
        Order order = TestDataFactory.createOrder(account.Id, 'Draft');
        TestDataFactory.createOrderItem(order.Id, pricebookEntry.Id, 2, 500);

        // Execution du test
        Test.startTest();
        order.ShipmentCost__c = null;
        update order;
        Test.stopTest();

        // Verification
        Order updatedOrder = [SELECT NetAmount__c FROM Order WHERE Id = :order.Id];
        System.assertEquals(
            null, 
            updatedOrder.NetAmount__c, 
            'NetAmount doit etre null si ShipmentCost est null'
        );
    }
}