trigger MotosTrigger on Mi_moto__c (before insert, before update) {
MiMotoTriggerHandler handler = new MiMotoTriggerHandler();


    if(Trigger.isInsert && Trigger.isBefore){
        handler.beforeInsert(Trigger.new);
    }

    else if(Trigger.isUpdate && Trigger.isBefore){
        handler.beforeUpdate(Trigger.old, Trigger.oldMap,Trigger.new, Trigger.newMap);
    }
}

    