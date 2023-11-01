public with sharing class MiMotoTriggerHandler {

    public void beforeInsert(List<Mi_moto__C> newSObjects){

            set<Id> ModeloIds = new Set<Id>();
            
            for(Mi_moto__c newMi_moto : newSObjects){
                    ModeloIds.add(newMi_moto.Modelo__c);
                
            }    
    
            Map<Id, Modelo__c> ModelosById = preloadRelatedMotos(ModeloIds);
            
            for(Mi_moto__c newMi_moto : newSObjects){
            populateSiguienteRevision(newMi_moto, ModelosById);
            }
            
            }
        
    


    public void beforeUpdate(
        List<Mi_moto__C> oldSObjects,
        Map<Id, Mi_moto__C> oldSObjectsMap,
        List<Mi_moto__C> updatedSObjects,
        Map<Id,Mi_moto__C> updatedSObjectsMap){

            set<Id> ModeloIds = new Set<Id>();
            
            for(Mi_moto__c newMi_moto : updatedSObjects){
                Mi_moto__c oldMi_moto = oldSObjectsMap.get(newMi_moto.Id);
                if (oldMi_moto.Ultima_Revision__c != newMi_moto.Ultima_Revision__c){
                    ModeloIds.add(newMi_moto.Modelo__c);
                }
                
            }


            Map<Id, Modelo__c> ModelosById = preloadRelatedMotos(ModeloIds);    
    
    
            for(Mi_moto__c newMi_moto : updatedSObjects){
    
               Mi_moto__C oldMi_moto = oldSObjectsMap.get(newMi_moto.Id);
               if (oldMi_moto.Ultima_Revision__c != newMi_moto.Ultima_Revision__c){

               populateSiguienteRevision(newMi_moto, ModelosById);

               }

                }
            }

        

            private static Map<Id, Modelo__c> preloadRelatedMotos(Set<Id> ModeloIds){
            List<Modelo__c> Modelos =    [SELECT Frecuencia_Revision__c FROM Modelo__c WHERE Id IN :ModeloIds];
             
            return new Map<Id, Modelo__c>(Modelos);

         } 
         
        private static void populateSiguienteRevision(Mi_moto__C newMi_moto, Map<Id, Modelo__c> ModelosById){
            
    
                Id ModeloId = newMi_moto.Modelo__c;
    
                Modelo__c Modelo = ModelosById.get(ModeloId);
    
    
                Integer daysToAdd = MotoFrecuencia.getDiasRevision(Modelo);
    
                newMi_moto.Proxima_Revision__C = newMi_moto.Ultima_Revision__c.addDays(daysToAdd);

                
        } 


        
    }

