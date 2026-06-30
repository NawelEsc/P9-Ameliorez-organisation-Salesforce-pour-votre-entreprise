/**
 * Composant : orderSummary
 * Description : Récupère et affiche le montant total
 *               des commandes Activated du compte courant.
 */
import { LightningElement, api } from 'lwc';
import getSumOrdersByAccount from '@salesforce/apex/MyTeamOrdersController.getSumOrdersByAccount';

export default class OrderSummary extends LightningElement {

    // Montant total des commandes du compte courant
    sumOrdersOfCurrentAccount;

    // ID du compte courant récupéré depuis la page Salesforce
    @api recordId;

    /**
     * Initialisation du composant —
     * récupère le total des commandes au chargement.
     */
    connectedCallback() {
        this.fetchSumOrders();
    }

    /**
     * Appelle la méthode Apex pour récupérer
     * le montant total des commandes Activated.
     */
    fetchSumOrders() {
        getSumOrdersByAccount({ accountId: this.recordId })
            .then(result => {
                this.sumOrdersOfCurrentAccount = result;
            })
            .catch(error => {
                console.error('Erreur lors de la récupération du total des commandes :', error);
            });
    }
}