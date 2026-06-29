/**
 * Classe : UpdateAllAccounts
 * Description : Batch Apex qui met à jour le chiffre d'affaires
 *               de tous les comptes ayant des commandes "Activated".
 * Utilisation : Database.executeBatch(new UpdateAllAccounts());
 */
global class UpdateAllAccounts implements Database.Batchable<sObject> {

    /**
     * Sélectionne uniquement les comptes ayant au moins
     * une commande au statut "Activated".
     */
    global Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator(
            'SELECT Id FROM Account ' +
            'WHERE Id IN (SELECT AccountId FROM Order WHERE Status = \'Activated\')'
        );
    }

    /**
     * Traite chaque lot de comptes et met à jour
     * leur chiffre d'affaires via UpdateAccounts.
     */
    global void execute(Database.BatchableContext context, List<Account> scope) {
        Set<Id> accountIds = new Map<Id, SObject>(scope).keySet();
        UpdateAccounts.updateChiffreAffaires(accountIds);
    }

    /**
     * Méthode de fin de traitement du batch.
     */
    global void finish(Database.BatchableContext context) {
        System.debug('Batch UpdateAllAccounts termine avec succes.');
    }
}