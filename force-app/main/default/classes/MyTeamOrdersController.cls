/**
 * Classe : MyTeamOrdersController
 * Description : Contrôleur Apex pour le composant LWC "orders".
 *               Retourne le montant total des commandes "Activated"
 *               du compte sur lequel le composant est affiché.
 */
public with sharing class MyTeamOrdersController {

    /**
     * Retourne la somme des commandes au statut "Activated"
     * pour un compte donné.
     * @param accountId - ID du compte courant
     * @return Decimal - Montant total des commandes Activated
     */
    @AuraEnabled(cacheable=true)
    public static Decimal getSumOrdersByAccount(Id accountId) {
        
        AggregateResult result = [
            SELECT SUM(TotalAmount) total
            FROM Order
            WHERE AccountId = :accountId
            AND Status = 'Activated'
        ];

        return (Decimal) result.get('total');
    }
}

