global class UpdateAllAccounts implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext info){ 
        return Database.getQueryLocator(
            'SELECT Id FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status = \'Activated\')'
        );
    }
     
    global void execute(Database.BatchableContext info, List<Account> scope){
        Set<Id> setAccountIds = (new Map<Id,SObject>(scope)).keySet();
        
        List<AggregateResult> results = [
            SELECT AccountId, SUM(TotalAmount) total 
            FROM Order 
            WHERE AccountId IN :setAccountIds 
            AND Status = 'Activated'
            GROUP BY AccountId
        ];
        
        List<Account> accountsToUpdate = new List<Account>();
        
        for(AggregateResult ar : results) {
            Account acc = new Account(
                Id = (Id)ar.get('AccountId'),
                Chiffre_d_affaire__c = (Decimal)ar.get('total')
            );
            accountsToUpdate.add(acc);
        }
        
        if(!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }    
     
    global void finish(Database.BatchableContext info){     
        
    } 
}