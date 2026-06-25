/**
 * Classe de test : testUpdateAllAccounts
 * Description : Teste le trigger UpdateAccountCA et le batch UpdateAllAccounts.
 * Utilise TestDataFactory pour la création des données de test.
 */
@isTest
public class testUpdateAllAccounts {

    /**
     * Teste que le trigger UpdateAccountCA met à jour
     * le chiffre d'affaires du compte au passage en "Activated".
     */
    @isTest
    static void testUpdateAccountCA() {
        // Création des données de test
        Account account = TestDataFactory.createAccount('Test Account 1');
        Product2 product = TestDataFactory.createProduct('Chemise Verte longue XYX', 'Chemise');
        PricebookEntry pricebookEntry = TestDataFactory.createPricebookEntry(product.Id, 1020);
        Order order = TestDataFactory.createOrder(account.Id, 'Draft');
        TestDataFactory.createOrderItem(order.Id, pricebookEntry.Id, 10, 150);
        TestDataFactory.createOrderItem(order.Id, pricebookEntry.Id, 20, 1000);

        // Execution du test
        Test.startTest();
        order.Status = 'Activated';
        update order;
        Test.stopTest();

        // Verification
        Account updatedAccount = [SELECT Chiffre_d_affaire__c FROM Account WHERE Id = :account.Id];
        System.assertNotEquals(null, updatedAccount.Chiffre_d_affaire__c, 
            'Le chiffre d affaires ne doit pas etre null apres activation');
    }

    /**
     * Teste que le batch UpdateAllAccounts met à jour
     * correctement le chiffre d'affaires de tous les comptes.
     */
    @isTest
    static void testUpdateAllAccountsBatch() {
        // Création des données de test
        Account account = TestDataFactory.createAccount('Test Account Batch');
        Product2 product = TestDataFactory.createProduct('Chemise Batch', 'Chemise');
        PricebookEntry pricebookEntry = TestDataFactory.createPricebookEntry(product.Id, 1020);
        Order order = TestDataFactory.createOrder(account.Id, 'Draft');
        TestDataFactory.createOrderItem(order.Id, pricebookEntry.Id, 10, 150);
        TestDataFactory.createOrderItem(order.Id, pricebookEntry.Id, 20, 1000);

        order.Status = 'Activated';
        update order;

        // Execution du batch
        Test.startTest();
        UpdateAllAccounts batch = new UpdateAllAccounts();
        Database.executeBatch(batch);
        Test.stopTest();

        // Verification
        Account updatedAccount = [SELECT Chiffre_d_affaire__c FROM Account WHERE Id = :account.Id];
        System.assertNotEquals(null, updatedAccount.Chiffre_d_affaire__c, 
            'Le chiffre d affaires ne doit pas etre null apres execution du batch');
    }
}