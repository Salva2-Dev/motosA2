trigger MotosTrigger on Mi_moto__c (before insert, before update) {

//List<Modelo__c> Modelos =    [SELECT Frecuencia_Revision__c FROM Modelo__c WHERE Id IN :ModeloIds];

    if(trigger.isInsert || trigger.isUpdate){
        set<Id> ModeloIds = new Set<Id>();
        for(Mi_moto__c newMi_moto : Trigger.new){
            Mi_moto__c oldMi_moto = Trigger.oldMap.get(newMi_moto.Id);
            if(oldMi_moto == null  ||   (oldMi_moto.Ultima_Revision__c != newMi_Moto.Ultima_Revision__c)){
                
                
                
                ModeloIds.add(newMi_moto.Modelo__c);

            }
        }

        List<Modelo__c> Modelos =    [SELECT Frecuencia_Revision__c FROM Modelo__c WHERE Id IN :ModeloIds];
         
        Map<Id, Modelo__c> ModelosById = new Map<Id, Modelo__c>(Modelos);



        for(Mi_moto__c newMi_moto : Trigger.new){
            Mi_moto__c oldMi_moto = Trigger.oldMap.get(newMi_moto.Id);
            if(oldMi_moto == null  ||   (oldMi_moto.Ultima_Revision__c != newMi_Moto.Ultima_Revision__c)){
                
                
                
                Id ModeloId = newMi_moto.Modelo__c;

                Modelo__c Modelo = ModelosById.get(ModeloId);


                Integer daysToAdd = MotoFrecuencia.getDiasRevision(Modelo);

                newMi_moto.Proxima_Revision__C = newMi_moto.Ultima_Revision__c.addDays(daysToAdd);
            }



        }
    }
}