/**
 * Classe de test : testMyTeamOrdersController
 * Description : Teste la classe MyTeamOrdersController.
 * Vérifie que getSumOrdersByAccount retourne le bon montant.
 */
@isTest
public class testMyTeamOrdersController {

    /**
     * Teste que getSumOrdersByAccount retourne
     * le total des commandes Activated du compte.
     */
    @isTest
    static void testGetSumOrdersByAccount() {
        // Création des données de test
        Account account = TestDataFactory.createAccount('Test Account LWC');
        Product2 product = TestDataFactory.createProduct('Chemise LWC', 'Chemise');
        PricebookEntry pricebookEntry = TestDataFactory.createPricebookEntry(product.Id, 500);
        Order order = TestDataFactory.createOrder(account.Id, 'Draft');
        TestDataFactory.createOrderItem(order.Id, pricebookEntry.Id, 2, 500);

        order.Status = 'Activated';
        update order;

        // Execution du test
        Test.startTest();
        Decimal total = MyTeamOrdersController.getSumOrdersByAccount(account.Id);
        Test.stopTest();

        // Verification
        System.assertEquals(
            1000, 
            total, 
            'Le total des commandes doit etre 1000'
        );
    }

    /**
     * Teste que getSumOrdersByAccount retourne null
     * si le compte n'a pas de commandes Activated.
     */
    @isTest
    static void testGetSumOrdersByAccountNoOrders() {
        // Création des données de test
        Account account = TestDataFactory.createAccount('Test Account Sans Commandes');

        // Execution du test
        Test.startTest();
        Decimal total = MyTeamOrdersController.getSumOrdersByAccount(account.Id);
        Test.stopTest();

        // Verification
        System.assertEquals(
            null, 
            total, 
            'Le total doit etre null si pas de commandes Activated'
        );
    }
}