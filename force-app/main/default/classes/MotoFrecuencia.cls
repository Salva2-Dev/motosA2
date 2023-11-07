public with sharing class MotoFrecuencia {
   

    public static Integer getDiasRevision(Modelo__c Modelo) {

        Integer frecuenciaInteger = Modelo.Frecuencia_Revision__c.intValue();

        return frecuenciaInteger;

    }


public static Integer getDiasCambioAceite(Modelo__c Modelo) {
    Integer frecuenciaInteger = Modelo.Frecuencia_Cambio_Aceite__c.intValue();

        return frecuenciaInteger;
    }
}