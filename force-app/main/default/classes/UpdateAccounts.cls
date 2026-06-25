/**
 * Classe : UpdateAccounts
 * Description : Contient la logique métier de mise à jour
 *               du chiffre d'affaires des comptes.
 * Utilisée par : UpdateAccountCA.trigger et UpdateAllAccounts.cls
 */
public with sharing class UpdateAccounts {

    /**
     * Met à jour le chiffre d'affaires des comptes
     * en calculant la somme des commandes au statut "Activated".
     * @param accountIds - Set des IDs des comptes à mettre à jour
     */
    public static void updateChiffreAffaires(Set<Id> accountIds) {

        // Récupérer les comptes concernés
        Map<Id, Account> accountMap = new Map<Id, Account>(
            [SELECT Id, Chiffre_d_affaire__c 
             FROM Account 
             WHERE Id IN :accountIds]
        );

        // Calculer la somme des commandes Activated par compte
        List<AggregateResult> orderTotals = [
            SELECT AccountId, SUM(TotalAmount) total
            FROM Order
            WHERE AccountId IN :accountIds
            AND Status = 'Activated'
            GROUP BY AccountId
        ];

        // Mettre à jour le chiffre d'affaires de chaque compte
        for (AggregateResult result : orderTotals) {
            Id accountId = (Id) result.get('AccountId');
            Decimal total = (Decimal) result.get('total');
            accountMap.get(accountId).Chiffre_d_affaire__c = total;
        }

        update accountMap.values();
    }
}