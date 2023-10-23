public with sharing class MotoService {
@AuraEnabled(cacheable=true)

public static List<Modelo__c> getAllModelos(){
 return[
    SELECT Id, Name, Precio__C, Marca__c, Imagen__c, Procedencia__c
    FROM Modelo__c
 ];
}
}