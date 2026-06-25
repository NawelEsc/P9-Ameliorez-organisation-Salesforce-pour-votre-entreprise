/**
 * Classe : TestDataFactory
 * Description : Classe utilitaire pour la création de données de test.
 *               Centralise la création des objets Salesforce utilisés
 *               dans les classes de test pour éviter la duplication de code.
 */
@isTest
public class TestDataFactory {

    /**
     * Crée et insère un compte.
     * @param name - Nom du compte
     * @return Account - Compte créé
     */
    public static Account createAccount(String name) {
        Account account = new Account(Name = name);
        insert account;
        return account;
    }

    /**
     * Crée et insère un produit.
     * @param name - Nom du produit
     * @param family - Famille du produit
     * @return Product2 - Produit créé
     */
    public static Product2 createProduct(String name, String family) {
        Product2 product = new Product2(Name = name, Family = family);
        insert product;
        return product;
    }

    /**
     * Crée et insère une entrée de catalogue de prix.
     * @param productId - ID du produit
     * @param unitPrice - Prix unitaire
     * @return PricebookEntry - Entrée créée
     */
    public static PricebookEntry createPricebookEntry(Id productId, Decimal unitPrice) {
        PricebookEntry pricebookEntry = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = productId,
            UnitPrice = unitPrice,
            IsActive = true
        );
        insert pricebookEntry;
        return pricebookEntry;
    }

    /**
     * Crée et insère une commande.
     * @param accountId - ID du compte
     * @param status - Statut de la commande
     * @return Order - Commande créée
     */
    public static Order createOrder(Id accountId, String status) {
        Order order = new Order(
            AccountId = accountId,
            Status = status,
            EffectiveDate = Date.today(),
            Pricebook2Id = Test.getStandardPricebookId()
        );
        insert order;
        return order;
    }

    /**
     * Crée et insère une ligne de commande.
     * @param orderId - ID de la commande
     * @param pricebookEntryId - ID de l'entrée catalogue
     * @param quantity - Quantité
     * @param unitPrice - Prix unitaire
     * @return OrderItem - Ligne de commande créée
     */
    public static OrderItem createOrderItem(Id orderId, Id pricebookEntryId, Integer quantity, Decimal unitPrice) {
        OrderItem orderItem = new OrderItem(
            OrderId = orderId,
            PricebookEntryId = pricebookEntryId,
            Quantity = quantity,
            UnitPrice = unitPrice
        );
        insert orderItem;
        return orderItem;
    }
}