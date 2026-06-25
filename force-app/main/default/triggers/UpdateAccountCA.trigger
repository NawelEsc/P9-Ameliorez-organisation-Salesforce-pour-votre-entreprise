/**
 * Trigger : UpdateAccountCA
 * Objet : Order
 * Description : Met à jour le chiffre d'affaires du compte
 *               lorsqu'une commande passe au statut "Activated".
 * Appelle : UpdateAccounts.updateChiffreAffaires()
 */
trigger UpdateAccountCA on Order (after update) {

    // Collecter les IDs des comptes dont les commandes viennent de passer en "Activated"
    Set<Id> accountIds = new Set<Id>();

    for (Order updatedOrder : Trigger.new) {
        Order previousOrder = Trigger.oldMap.get(updatedOrder.Id);
        Boolean statusChangedToActivated = (
            updatedOrder.Status == 'Activated' && 
            previousOrder.Status != 'Activated'
        );

        if (statusChangedToActivated) {
            accountIds.add(updatedOrder.AccountId);
        }
    }

    if (!accountIds.isEmpty()) {
        UpdateAccounts.updateChiffreAffaires(accountIds);
    }
}