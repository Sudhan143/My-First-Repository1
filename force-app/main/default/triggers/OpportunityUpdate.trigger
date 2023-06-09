trigger OpportunityUpdate on Opportunity (before insert,after update) {
    
    if(Trigger.isUpdate && Trigger.isAfter){
        List<ID> oppIDsofupdatedstagename = new List<ID>();
      map<Id,string> m= new map<Id,string>();
        
        for(Opportunity opp: Trigger.new){
            Opportunity opp1 = Trigger.oldMap.get(opp.id);
            if(opp.StageName!= opp1.StageName){
                oppIDsofupdatedstagename.add(opp.AccountId);
               m.put(opp.AccountId,opp.StageName);
            }
        }
          
        List<Account> acclist = [select id,name from account where id in :oppIDsofupdatedstagename];
        List<Account> acc1 = new List<Account>();
            system.debug(acclist);
        for(Account acc: acclist){
            acc.Account_Status__c = m.get(acc.id);
            acc1.add(acc);
        }
            if(acclist.size()>0)
            update acc1;
                
            }
                
        }